class UserMailer < ApplicationMailer
  default from: "samishra@bestpeers.in"

  def welcome_email
    @user = params[:user]
    @url  = "http://localhost:3000/login"
    mail(to: @user.email, subject: "Welcome to My Awesome Site")
  end

  def approved_application_email
    @user = params[:user]
    @url  = "http://localhost:3000/login"
    mail(to: @user.email, subject: "Application Status Update ")
  end

  def rejected_application_email
    @user = params[:user]
    @url  = "http://localhost:3000/login"
    mail(to: @user.email, subject: "Application Status Update ")
  end
  def new_application_email
    @task = params[:task]
    @url  = "http://localhost:3000/login"
    mail(to: @task.contractor.email, subject: "New application")
  end
end
