class CompetenciesController < ApplicationController
  layout "admin"

  # Callback Methods
  before_action :set_competency, only: [:show, :edit, :update, :destroy]
  before_action :check_login
  # GET /competencies
  def index
    @active_competencies = Competency.active.alphabetical
    @inactive_competencies = Competency.inactive.alphabetical
  end

  # GET /competencies/:id
  def show
  end

  # GET /competencies/new
  def new
    @competency = Competency.new
  end

  # POST /competencies
  def create
    @competency = Competency.new(competency_params)
    if @competency.save
      flash[:notice] = "Successfully created #{@competency.name}"
      redirect_to competency_path(@competency)
    else
      render "new"
    end
  end

  # GET /competencies/:id/edit
  def edit
  end

  # PATCH/PUT /competencies/:id
  def update
    if @competency.update(competency_params)
      flash[:notice] = "Successfully updated #{@competency.name}"
      redirect_to competency_path(@competency)
    else
      render "edit"
    end
  end

  # DELETE /competencies/:id
  def destroy
    @competency.destroy
    flash[:notice] = "Successfully deleted #{@competency.name}"
    redirect_to competencies_path
  end


  private

  # Use callbacks to share common setup or constraints between actions.
  def set_competency
    @competency = Competency.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def competency_params
    params.require(:competency).permit(:name, :description, :active)
  end
end
