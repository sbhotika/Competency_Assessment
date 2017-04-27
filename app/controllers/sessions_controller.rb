class SessionsController < ApplicationController
  # GET /login
  def new
  end

  # POST /login
  def create
    user = User.find_by_username(params[:username]).first
    # If the user exists AND the password entered is correct.
    if user && user.authenticate(params[:password])
      # Save the user id
      session[:user_id] = user.id
      flash[:notice] = "Login Successful"
      redirect_to root_path
    else
      flash[:error] = "Login Failed"
      redirect_to login_path
    end
  end

  # GET Logout
  def destroy
    session[:user_id] = nil
    flash[:notice] = "Logged Out"
    redirect_to login_path
  end
end
