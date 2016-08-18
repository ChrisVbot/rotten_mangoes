class Admin::UsersController < ApplicationController

  before_action do
    unless current_user.admin?
      flash[:notice] = "Access denied - only admins allowed!"
      redirect_to '/'
    end
  end

  def index
    @users = User.order("id").page(params[:page]).per(10)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.password = (0..8).map {(65 + rand(26)).chr}.join #generates password for user
    if @user.save
      UserMailer.admin_welcome_email(@user).deliver_now
      redirect_to admin_users_path, notice: "New user created with username #{@user.email}."
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def destroy
    @user = User.find(params[:id])
    UserMailer.delete_email(@user).deliver_now
    @user.destroy
    redirect_to admin_users_path, notice: "User deleted"
  end

  protected
  def user_params
    params.require(:user).permit(:email, :firstname, :lastname, :admin)
  end

end

#admins should never know users passwords - should not require it in the strong params! Need separate create field here! Create random pw which is sent to user - they log in and immediately change pw. 

