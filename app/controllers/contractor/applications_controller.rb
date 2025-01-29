class Contractor::ApplicationsController < ApplicationController
  before_action :set_application, only: [ :approve, :reject ]

  def index
    @task = current_user.tasks.application_count
    if @task.nil?
      flash[:alert] = "Task not found."
      redirect_to contractor_tasks_path
    end
  end
  def show
    @task = Task.find(params[:id])
    @application = @task.applications.includes(:worker)
  end
  # def index
  #   @task = Task.find(params[:task_id])
  #   @applications = @task.task_applications.includes(:worker)
  # end

  def approve
    @application.update(status: "Approved")
    redirect_to task_applications_path(@application.task), notice: "Application approved successfully."
  end

  def reject
    @application.update(status: "Rejected")
    redirect_to task_applications_path(@application.task), alert: "Application rejected successfully."
  end

  private

  def set_application
    @application = TaskApplication.find(params[:id])
  end
end
