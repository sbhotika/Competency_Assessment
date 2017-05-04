class IndicatorQuestionsController < ApplicationController
  layout "admin"

  # Callback Methods
  before_action :set_indicator_question, only: [:show, :edit, :update, :destroy]
  before_action :check_login

  def index
  end

  def show
  end

  def new
    @indicator_question = IndicatorQuestion.new
    @question = Question.find_by(params[:question])
    @competency_id = params[:competency_id]
  end

  def create
    @competency_id = params[:competency_id]
    @indicator_question = IndicatorQuestion.new(indicator_question_params)
    @question = @indicator_question.question
    if @indicator_question.save
      # QUESTION: Should we truncate the indicator text so it only shows the first 5 words?
      flash[:notice] = "Successfully added '#{@indicator_question.indicator.description}' indicator to this question."
      # This assumes we add/delete IndicatorQuestions in the show question page
      redirect_to question_path(@question, :competency_id => @competency_id)
    else
      flash[:error] = "Indicator Question failed to save."
      redirect_to question_path(@question, :competency_id => @competency_id)
    end
  end

  def edit
  end

  # This action is not necessary as the user will only ever be creating a new or destroying a mapping
  def update
  end

  def destroy
    @competency_id = params[:competency_id]
    @question = @indicator_question.question
    @indicator_question.destroy
    flash[:notice] = "Successfully deleted Indicator Question mapping"
    redirect_to question_path(@question, :competency_id => @competency_id)
  end

  #----------------------------------
  private
  #----------------------------------

  def set_indicator_question
    @indicator_question = IndicatorQuestion.find(params[:id])
  end

  def indicator_question_params
    params.require(:indicator_question).permit(:indicator_id, :question_id)
  end

end
