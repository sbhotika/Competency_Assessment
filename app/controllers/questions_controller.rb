class QuestionsController < ApplicationController
  layout "admin"
  # Callback Methods
  before_action :set_question, only: [:show, :edit, :update, :destroy]
  before_action :check_login

  # GET /questions
  def index
    # Get questions related to the competency
    @active_questions = Question.active.for_competency(params[:competency_id])
    @inactive_questions = Question.inactive.for_competency(params[:competency_id])
    @competency_id = params[:competency_id]
    @competency = Competency.find(params[:competency_id])
  end

  # GET /questions/:id
  def show
    @indicator_questions = @question.indicator_questions
    @competency_id = params[:competency_id]
  end

  # GET /questions/new
  def new
    @question = Question.new
    @competency_id = params[:competency_id]
  end

  # POST /questions
  def create
    @question = Question.new(question_params)
    @competency_id = params[:competency_id]
    if @question.save
      flash[:notice] = "Successfully created #{@question.question}"
      redirect_to question_path(@question, :competency_id => @competency_id)
    else
      redirect_to new_question_path(:competency_id => @competency_id)
    end
  end

  # GET /questions/:id/edit
  def edit
    @competency_id = params[:competency_id]
  end

  # PATCH/PUT /questions/:id
  def update
    @competency_id = params[:competency_id]
    if @question.update(question_params)
      flash[:notice] = "Successfully updated #{@question.question}"
      redirect_to question_path(@question, :competency_id => @competency_id)
    else
      redirect_to edit_question_path(:competency_id => @competency_id)
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
