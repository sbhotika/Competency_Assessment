class IndicatorResourcesController < ApplicationController
  layout "admin"
  # Callback Methods
  before_action :set_indicator_resource, only: [:show, :edit, :update, :destroy]
  before_action :check_login

  def index
  end

  def show
  end

  def new
    @indicator_resource = IndicatorResource.new
    @indicator = Indicator.find_by(params[:indicator])
    @competency_id = params[:competency_id]
  end

  def create
    @competency_id = params[:competency_id]
    @indicator_resource = IndicatorResource.new(indicator_resource_params)
    @indicator = @indicator_resource.indicator
    if @indicator_resource.save
      flash[:notice] = "Successfully created Indicator Resource mapping"
      # This assumes we add/delete IndicatorResources in the show indicator page
      redirect_to indicator_path(@indicator, :competency_id => @competency_id)
    else
      flash[:error] = "IndicatorResource failed to save."
      redirect_to indicator_path(@indicator, :competency_id => @competency_id)
    end
  end

  def edit
  end

  # This action is not necessary as the user will only ever be creating a new or destroying a mapping
  def update
  end

  def destroy
    @competency_id = params[:competency_id]
    @indicator = @indicator_resource.indicator
    @indicator_resource.destroy
    flash[:notice] = "Successfully deleted Indicator Resource mapping"
    redirect_to indicator_path(@indicator, :competency_id => @competency_id)
  end

  #----------------------------------
  private
  #----------------------------------

  def set_indicator_resource
    @indicator_resource = IndicatorResource.find(params[:id])
  end

  def indicator_resource_params
    params.require(:indicator_resource).permit(:indicator_id, :resource_id)
  end

end
