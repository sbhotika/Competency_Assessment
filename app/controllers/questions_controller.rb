class QuestionsController < ApplicationController
  layout "admin"
  # Callback Methods
  before_action :set_question, only: [:show, :edit, :update, :destroy]

  # GET /questions
  def index
    @active_questions = Question.active.alphabetical
    @inactive_questions = Question.inactive.alphabetical
  end

  # GET /questions/:id
  def show
    @indicator_questions = @question.indicator_questions
  end

  # GET /questions/new
  def new
    @question = Question.new
  end

  # POST /questions
  def create
    @question = Question.new(question_params)
    if @question.save
      flash[:notice] = "Successfully created #{@question.question}"
      redirect_to question_path(@question)
    else
      render "new"
    end
  end

  # GET /questions/:id/edit
  def edit
  end

  # PATCH/PUT /questions/:id
  def update
    if @question.update(question_params)
      flash[:notice] = "Successfully updated #{@question.question}"
      redirect_to question_path(@question)
    else
      render "edit"
    end
  end

  # DELETE /questions/:id
  def destroy
    @question.destroy
    flash[:notice] = "Successfully deleted #{@question.question}"
    redirect_to questions_path
  end


  private

  # Use callbacks to share common setup or constraints between actions.
  def set_question
    @question = Question.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def question_params
    params.require(:question).permit(:question, :active)
  end
end
