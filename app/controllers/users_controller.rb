class UsersController < ApplicationController
  before_action :set_params, only: [:create]

  def new
    redirect_to home_path if current_user
    @user = User.new
  end

  def create
    @user = User.new(set_params)
    if @user.save
      redirect_to sign_in_path
    else
      render :new
    end
  end

  private
  def set_params
    params.require(:user).permit(:email, :full_name, :password)
  end
end
