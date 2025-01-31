class Contractor::ApplicationsController < ApplicationController
  before_action :set_application, only: [ :approve, :reject ]

  def index
    # debugger
    @q = Application.ransack(params[:q])
    @application = @q.result
  end
  def show
    @task = Task.find(params[:id])
    @t= @task.applications.includes(:worker)
    @q = @t.ransack(params[:q])
    @application = @q.result
  end

  def approve
    @application = Application.find(params[:id])
    if @application.update(status: "approved")
      UserMailer.with(user: @application.worker).approved_application_email.deliver_now
      TwilioClient.new.send_text(@application.worker, "hello user..., how are you?")
      redirect_to contractor_applications_path, notice: "Application has been approved."
    end
  end


  def reject
    @application = Application.find(params[:id])
    if @application.update(status: "rejected")
      UserMailer.with(user: @application.worker).rejected_application_email.deliver_now
      redirect_to contractor_applications_path,  notice: "Application has been regected."
    end
  end

  private

  def set_application
    @application = Application.find(params[:id])
  end
end
