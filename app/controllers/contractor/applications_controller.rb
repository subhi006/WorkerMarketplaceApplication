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
    @application.update(status: "approved")
    redirect_to contractor_applications_path, notice: "Application approved successfully."
  end

  def reject
    @application.update(status: "rejected")
    redirect_to  contractor_applications_path, alert: "Application rejected successfully."
  end

  private

  def set_application
    @application = Application.find(params[:id])
  end
end
