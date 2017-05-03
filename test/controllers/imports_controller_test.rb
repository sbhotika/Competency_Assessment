require 'test_helper'

class ImportsControllerTest < ActionController::TestCase
  # Test all imports controller actions and methods
  setup do
    # Partial creation of Levels
    @champion = FactoryGirl.create(:level)
    # Partial creation of Paradigms
    @build_understanding = FactoryGirl.create(:paradigm)
  end

  # Test that uploading an invalid file type throws an TypeError
  test "should throw an error if invalid file type is uploaded" do
    assert_no_difference(['Competency.count', 'Level.count', 'Indicator.count', 'Paradigm.count', 
      'Resource.count', 'IndicatorResource.count', 'Question.count', 'IndicatorQuestion.count']) do

      uploaded_file = upload_file("competencies.csv")

      post :parse, file: uploaded_file
    end

    assert_redirected_to dashboard_path
  end

  # Test that uploading a xlsx file, parsing it properly, and saving to database works.
  test "should properly parse and import a correct xlsx file" do
    assert_differences([['Competency.count', 1], ['Level.count', 2], 
      ['Indicator.count', 24], ['Paradigm.count', 5], ['Resource.count', 100],
      ['IndicatorResource.count', 110], ['Question.count', 11], ['IndicatorQuestion.count', 29]]) do

      uploaded_file = upload_file("competencies.xlsx")

      post :parse, file: uploaded_file
    end

    assert_redirected_to dashboard_path
  end

  # Test that uploading an excel file with bad validation will throw error for independent models.
  test "should throw error with invalid excel spreadsheet (independent models)" do
    assert_no_difference(['Competency.count', 'Level.count', 'Indicator.count', 'Paradigm.count', 
      'Resource.count', 'IndicatorResource.count', 'Question.count', 'IndicatorQuestion.count']) do

      uploaded_file = upload_file("competencies_bad_levels.xlsx")

      post :parse, file: uploaded_file
    end

    assert_redirected_to dashboard_path
  end

  # Test that uploading an excel file with bad validation will throw error 
  # for first level of dependent models.
  # Should rollback previously created objects as well.
  test "should throw error with invalid excel spreadsheet (first level of dependent models)" do
    assert_no_difference(['Competency.count', 'Level.count', 'Indicator.count', 'Paradigm.count', 
      'Resource.count', 'IndicatorResource.count', 'Question.count', 'IndicatorQuestion.count']) do

      uploaded_file = upload_file("competencies_bad_indicators.xlsx")

      post :parse, file: uploaded_file
    end

    assert_redirected_to dashboard_path
  end

  # Test that uploading an excel file with bad validation will throw error 
  # for second level of dependent models (aka. many to many association tables).
  # Should rollback previously created objects as well.
  test "should throw error with invalid excel spreadsheet (second level of dependent models)" do
    assert_no_difference(['Competency.count', 'Level.count', 'Indicator.count', 'Paradigm.count', 
      'Resource.count', 'IndicatorResource.count', 'Question.count', 'IndicatorQuestion.count']) do

      uploaded_file = upload_file("competencies_bad_indicator_resources.xlsx")

      post :parse, file: uploaded_file
    end

    assert_redirected_to dashboard_path
  end

  # Test that error should be thrown for missing or mispelled sheet name
  test "should throw error with incorrect sheet name" do
    assert_no_difference(['Competency.count', 'Level.count', 'Indicator.count', 'Paradigm.count', 
      'Resource.count', 'IndicatorResource.count', 'Question.count', 'IndicatorQuestion.count']) do

      uploaded_file = upload_file("competencies_bad_sheet_name.xlsx")

      post :parse, file: uploaded_file
    end

    assert_redirected_to dashboard_path
  end

  # Test that error should be thrown for missing or mispelled column name
  # Should rollback previously created objects as well.
  test "should throw error with incorrect column name" do
    assert_no_difference(['Competency.count', 'Level.count', 'Indicator.count', 'Paradigm.count', 
      'Resource.count', 'IndicatorResource.count', 'Question.count', 'IndicatorQuestion.count']) do

      uploaded_file = upload_file("competencies_bad_column_name.xlsx")

      post :parse, file: uploaded_file
    end

    assert_redirected_to dashboard_path
  end

  # Test that error should be thrown for missing or mispelled sheet and column name
  # Should rollback previously created objects as well.
  test "should throw error with incorrect sheet and column name" do
    assert_no_difference(['Competency.count', 'Level.count', 'Indicator.count', 'Paradigm.count', 
      'Resource.count', 'IndicatorResource.count', 'Question.count', 'IndicatorQuestion.count']) do

      uploaded_file = upload_file("competencies_bad_sheet_column_name.xlsx")

      post :parse, file: uploaded_file
    end

    assert_redirected_to dashboard_path
  end

end