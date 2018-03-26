class IndicatorsController < ApplicationController
  layout 'admin'

  # Callback Methods
  before_action :set_indicator, only: [:show, :edit, :update, :destroy]
  before_action :set_competencies_levels, only: [:new, :create, :edit, :update]
  before_action :check_login

  # GET /indicators
  def index
    @competency_id = params[:competency_id]
    @competency = Competency.find(params[:competency_id])
    @active_indicators = Indicator.active.for_competency(params[:competency_id])
    @inactive_indicators = Indicator.inactive.for_competency(params[:competency_id])
  end

  # GET /indicators/:id
  def show
    @competency_id = params[:competency_id]
    @indicator_resources = @indicator.indicator_resources
  end

  # GET /indicators/new
  def new
    @indicator = Indicator.new
    @competency_id = params[:competency_id]
    @competency = Competency.find(params[:competency_id])
  end

  # POST /indicators
  def create
    @indicator = Indicator.new(indicator_params)
    @competency_id = params[:competency_id]
    if @indicator.save
      flash[:notice] = "Successfully created #{@indicator.description}"
      redirect_to indicator_path(@indicator, :competency_id => @competency_id)
    else
      redirect_to new_indicator_path(:competency_id => @competency_id)
    end
  end

  # GET /indicators/:id/edit
  def edit
    @competency_id = params[:competency_id]
    @competency = Competency.find(params[:competency_id])
  end

  # PATCH/PUT /indicators/:id
  def update
    @competency_id = params[:competency_id]
    if @indicator.update(indicator_params)
      flash[:notice] = "Successfully updated #{@indicator.description}"
      redirect_to indicator_path(@indicator, :competency_id => @competency_id)
    else
      redirect_to edit_indicator_path(:competency_id => @competency_id)
    end
  end

  # DELETE /indicators/:id
  def destroy
    @indicator.destroy
    @competency_id = params[:competency_id]
    flash[:notice] = "Successfully deleted #{@indicator.description}"
    redirect_to indicators_path(:competency_id => @competency_id)
  end


  private

  # Use callbacks to share common setup or constraints between actions.
  def set_indicator
    @indicator = Indicator.find(params[:id])
  end

  # Use callback to create the competencies and levels for forms
  def set_competencies_levels
    @active_competencies = Competency.active.alphabetical
    @active_levels = Level.active.alphabetical
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def indicator_params
    params.require(:indicator).permit(:competency_id, :level_id, :description, :active)
  end
end
