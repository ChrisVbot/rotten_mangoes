class Admin::UsersController < ApplicationController

  before_action do
    if current_user.nil? || current_user.admin == false
      flash[:notice] = "Access denied - only admins allowed!"
      redirect_to '/'
    end
  end

  def index
    @users = User.order("id").page(params[:page]).per(10)
  end

  def show
    @user = User.find(params[:id])
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_users_path, notice: "User deleted"
  end

end
