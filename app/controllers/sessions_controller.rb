class SessionsController < ApplicationController
  
  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      # if user.admin
      #   session[:admin_id] = user.id
      # end
      session[:user_id] = user.id
      redirect_to movies_path, notice: "Welcome back, #{user.firstname}"
    else
      # binding.pry
      flash.now[:alert] = "Log in failed."
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to movies_path, notice: "Logged out successfully!"
  end
end
