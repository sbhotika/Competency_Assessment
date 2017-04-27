class UsersController < ApplicationController
  #Callback Methods
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.active.alphabetical
    @inactive_users = User.inactive.alphabetical
  end

  def show
  end

  # GET /signup
  def new
    @user = User.new
  end

  # POST /users
  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Registration Successful"
      redirect_to root_path
    else
      render 'new'
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation)
  end
end
