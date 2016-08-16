class Admin::UsersController < ApplicationController

  before_action do
    if current_user.nil? || current_user.admin == false
      flash[:notice] = "Access denied - only admins allowed!"
      redirect_to '/'
    end
  end

  def index
    @users = User.all
  end

  # def new
  #   @user = User.new
  # end

  # def create
  #   @user = User.new(user_params)
  #   @user.admin = true
  #   if @user.save
  #     redirect_to movies_path, notice: "#{@user.email} has been added as an admin"
  #   else
  #     render :new
  #   end
  # end

  # protected
  # def admin_params
  #   params.require(:user).permit(:email)
  # end

end

