class SessionsController < ApplicationController

  def new
    redirect_to current_user if logged_in?
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:success] = "Welcome back to alphablog."
      redirect_to user_path(user)
    else
      flash[:danger] = "There was something wrong with your login information"
      redirect_to login_path
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "You have been logged out"
    redirect_to root_path
  end

  private

end
