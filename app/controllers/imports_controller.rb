require 'roo'

class ImportsController < ApplicationController

  ACCEPTED_FORMATS = [".xls", ".xlsx"]
  EXCEPTION_ERROR_MSG = "Excel file, sheets, or columns may be in the wrong format or mispelled. Please check the template file for reference."

  # POST /imports/parse
  def parse
    file = params[:file]
    # Check if the the file is of the right type. Redirect to the upload url early if it's not correct.
    begin
      unless ACCEPTED_FORMATS.include? File.extname(file.original_filename)
        raise TypeError
      end
      spreadsheet = open_spreadsheet(file)
    rescue => exception
      flash[:error] = "#{file.nil? ? 'File' : file.original_filename} is in the wrong format. Has to be .xls or .xlsx"
      return redirect_to dashboard_path
    end

    # Parses each of the sheets

    # Part 1
    # Returns a list of ActiveRecords that need to be saved into the database.
    # For specific models like Level, it returns a list of all levels listed in the Excel file as well as 
    # the the list of new objects that need to be saved. This is because the same exact levels will generally 
    # be in every Excel file, but we don't need to redundantly save it into the database each time. 
    # This is wrapped around with a begin rescue for errors that pertain to the overall format of the 
    # excel spreadsheet including mispelled or incorrect sheet names and column names.
    begin
      competencies = Competency.parse(spreadsheet)
      levels, new_levels = Level.parse(spreadsheet)
      paradigms, new_paradigms = Paradigm.parse(spreadsheet)
      questions = Question.parse(spreadsheet)
    rescue => exception
      flash[:error] = EXCEPTION_ERROR_MSG
      return redirect_to dashboard_path
    end
    all_models = [competencies, levels, paradigms, questions]
    new_models = [competencies, new_levels, new_paradigms, questions]
    
    # Validate that the new models are all valid and save them to the database.
    # If any of the new models are not valid, all errors that need to be fixed will be aggregated.
    unless validate_save_models(new_models)
      aggregate_errors(all_models)
      return redirect_to dashboard_path
    end

    # Part 2
    # Because these following models are dependent on the id's and creation of the previous models,
    # they have to be parsed, validated and saved afterwards.
    begin
      indicators = Indicator.parse(spreadsheet, competencies, levels)
      resources = Resource.parse(spreadsheet, paradigms)
    rescue => exception
      rollback_saved_models(new_models)
      flash[:error] = EXCEPTION_ERROR_MSG
      return redirect_to dashboard_path
    end
    dependent_models = [indicators, resources]

    # Same behavior as before, except since previous models were saved, 
    # this will rollback and destroy the created models if there is something invalid.
    unless validate_save_models(dependent_models)
      rollback_saved_models(new_models)
      aggregate_errors(dependent_models)
      return redirect_to dashboard_path
    end

    # Part 3
    # This begins the third level of dependencies for many to many association tables
    begin
      indicator_resources = IndicatorResource.parse(spreadsheet, indicators, resources)
      indicator_questions = IndicatorQuestion.parse(spreadsheet, indicators, questions)
    rescue => exception
      rollback_saved_models(new_models + dependent_models)
      flash[:error] = EXCEPTION_ERROR_MSG
      return redirect_to dashboard_path
    end
    dependent_models_2 = [indicator_resources, indicator_questions]

    # Validate the new models and roll back the previous 2 levels of models.
    unless validate_save_models(dependent_models_2)
      rollback_saved_models(new_models + dependent_models)
      aggregate_errors(dependent_models_2)
      return redirect_to dashboard_path
    end

    # Redirect to the original page with success message if no errors have occurred in any of the models
    flash[:notice] = "Successfully uploaded and imported the #{file.original_filename} spreadsheet."
    redirect_to dashboard_path
  end


  private

  # Takes in the list of all models that need to be saved into the database.
  # Checks if the new objects are valid, before saving into the databse.
  # Nothing is saved unless everything is valid.
  #
  # Note: Stops after the first sheet that encounters and error, therefore, error messages
  # will only be for the first sheet that has errors, not error messages for all sheets.
  def validate_save_models(models_list)
    # Goes through all the models and see if its valid and returns false if any of them are invalid
    models_list.each do |models|
      unless models.map(&:valid?).all?
        return false
      end
    end
    # If all are valid, then save them and return true
    models_list.each do |models|
      models.each(&:save!)
    end
    return true
  end

  # This method is called if an error exists in the list of models 
  # (called for all model validation errors including blank rows or attributes and uniqueness)
  # Goes through all the models in order to aggregate the errors into flash[:error]
  # Don't use the new models (ex. new_levels vs. levels) because of Row #'s for error message.
  def aggregate_errors(models_list)
    flash[:error] = []
    models_list.each do |models|
      models.each_with_index do |m, index|
        m.errors.full_messages.each do |message|
          flash[:error] << "#{m.class.name.pluralize} Sheet - Row #{index+2}: #{message}"
        end
      end
    end
  end

  # This handles rollback actions if any of the models were created and later on models had an error.
  def rollback_saved_models(models_list)
    models_list.each do |models|
      models.each(&:destroy!)
    end
  end

  # Using roo's library and opens up the file and parses it into a Roo object (either XLS, XLSX, or CSV)
  def open_spreadsheet(file)
    Roo::Spreadsheet.open(file.path)
  end

end
