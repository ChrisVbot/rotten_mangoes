class UserMailer < ApplicationMailer
  default from: 'notifications@rottenmangoes.com'

  def welcome_email(user)
    @user = user
    @url = 'http://localhost:3000'
    mail(to: @user.email, subject: 'Welcome to Rotten Mangoes!')
  end

  def delete_email(user)
    @user = user
    @url = 'http://localhost:3000'
    mail(to: @user.email, subject: 'Your account has been deleted')
  end

  def admin_welcome_email(user)
    @user = user
    @url = 'http://localhost:3000'
    mail(to: @user.email, subject: 'An account has been created for you')
  end
end
