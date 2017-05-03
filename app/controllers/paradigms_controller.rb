class ParadigmsController < ApplicationController
  layout 'admin'

  # Callback Methods
  before_action :set_paradigm, only: [:show, :edit, :update, :destroy]
  before_action :check_login

  # GET /paradigms
  def index
    @active_paradigms = Paradigm.active.alphabetical
    @inactive_paradigms = Paradigm.inactive.alphabetical
  end

  # GET /paradigms/:id
  def show
  end

  # GET /paradigms/new
  def new
    @paradigm = Paradigm.new
  end

  # POST /paradigms
  def create
    @paradigm = Paradigm.new(paradigm_params)
    if @paradigm.save
      flash[:notice] = "Successfully created #{@paradigm.name}"
      redirect_to paradigm_path(@paradigm)
    else
      render "new"
    end
  end

  # GET /paradigms/:id/edit
  def edit
  end

  # PATCH/PUT /paradigms/:id
  def update
    if @paradigm.update(paradigm_params)
      flash[:notice] = "Successfully updated #{@paradigm.name}"
      redirect_to paradigm_path(@paradigm)
    else
      render "edit"
    end
  end

  # DELETE /paradigms/:id
  def destroy
    @paradigm.destroy
    flash[:notice] = "Successfully deleted #{@paradigm.name}"
    redirect_to paradigms_url
  end


  private

  # Use callbacks to share common setup or constraints between actions.
  def set_paradigm
    @paradigm = Paradigm.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def paradigm_params
    params.require(:paradigm).permit(:name, :description, :ranking, :active)
  end
end
