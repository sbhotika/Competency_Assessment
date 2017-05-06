class ResourcesController < ApplicationController
  layout "admin"

  # Callback Methods
  before_action :set_resource, only: [:show, :edit, :update, :destroy]
  before_action :set_paradigm, only: [:new, :create, :edit, :update]
  before_action :check_login

  # GET /resources
  def index
    @paradigms = Paradigm.all.alphabetical
    # Check if we are coming from manage competency page vs. nav bar
    # Nav bar should display all resources and won't have a competency id in the params
    if(params[:competency_id])
      @active_resources = Resource.for_competency(params[:competency_id]).active
      @inactive_resources = Resource.for_competency(params[:competency_id]).inactive
      @competency_id = params[:competency_id]
    else
      @active_resources = Resource.active.alphabetical
      @inactive_resources = Resource.inactive.alphabetical
    end
  end

  # GET /resources/:id
  def show
    @competency_id = params[:competency_id]
  end

  # GET /resources/new
  def new
    @resource = Resource.new
    @competency_id = params[:competency_id]
  end

  # POST /resources
  def create
    @resource = Resource.new(resource_params)
    if @resource.save
      flash[:notice] = "Successfully created #{@resource.title}"
      redirect_to resource_path(@resource)
    else
      render "new"
    end
  end

  # GET /resources/:id/edit
  def edit
    @competency_id = params[:competency_id]
  end

  # PATCH/PUT /resources/:id
  def update
    if @resource.update(resource_params)
      flash[:notice] = "Successfully updated #{@resource.title}"
      redirect_to resource_path(@resource,:competency_id => params[:competency_id])
    else
      render "edit"
    end
  end

  # DELETE /resources/:id
  def destroy
    @resource.destroy
    flash[:notice] = "Successfully deleted #{@resource.title}"
    redirect_to resources_path(:competency_id => params[:competency_id])
  end


  private

  # Use callbacks to share common setup or constraints between actions.
  def set_resource
    @resource = Resource.find(params[:id])
  end

  def set_paradigm
    @active_paradigms = Paradigm.active.alphabetical
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def resource_params
    params.require(:resource).permit(:title, :link, :paradigm_id, :active)
  end
end
