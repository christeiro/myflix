class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email]).authenticate(params[:password])
    if user
      session[:user_id] = user.id
      redirect_to home_path
    else
      flash[:error] = "Your username or password are incorrect! Please try again!"
      render :new
    end
  end

  def destroy
    session.clear
    flash[:notice] = "You've been logged out!"
    redirect_to root_path
  end
end