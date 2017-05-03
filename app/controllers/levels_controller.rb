class LevelsController < ApplicationController
  layout 'admin'

  # Callback Methods
  before_action :set_level, only: [:show, :edit, :update, :destroy]
  before_action :check_login

  # GET /levels
  def index
    @active_levels = Level.active.by_ranking
    @inactive_levels = Level.inactive.by_ranking
  end

  # GET /levels/:id
  def show
  end

  # GET /levels/new
  def new
    @level = Level.new
  end

  # POST /levels
  def create
    @level = Level.new(level_params)
    if @level.save
      flash[:notice] = "Successfully created #{@level.name}"
      redirect_to level_path(@level)
    else
      render "new"
    end
  end

  # GET /levels/:id/edit
  def edit
  end

  # PATCH/PUT /levels/:id
  def update
    if @level.update(level_params)
      flash[:notice] = "Successfully updated #{@level.name}"
      redirect_to level_path(@level)
    else
      render "edit"
    end
  end

  # DELETE /levels/:id
  def destroy
    @level.destroy
    flash[:notice] = "Successfully deleted #{@level.name}"
    redirect_to levels_path
  end


  private

  # Use callbacks to share common setup or constraints between actions.
  def set_level
    @level = Level.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def level_params
    params.require(:level).permit(:name, :description, :ranking, :active)
  end
end
