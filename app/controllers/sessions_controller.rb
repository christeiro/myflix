class SessionsController < ApplicationController
  def new
    redirect_to home_path if current_user
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to home_path
    else
      flash[:error] = "Your username or password are incorrect! Please try again!"
      redirect_to sign_in_path
    end
  end

  def destroy
    session.clear
    flash[:notice] = "You've been logged out!"
    redirect_to root_path
  end
end