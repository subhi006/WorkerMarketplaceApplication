class Worker::ApplicationsController < ApplicationController
  before_action :authenticate_user!
  def index
    @applications = current_user.applications
  end
  def create
    @task = Task.find(params[:task_id])
    debugger
    @application = @task.applications.build(worker: current_user, status: "applied")
    if @application.save
      redirect_to worker_tasks_path, notice: "You have successfully applied for the task."
    else
      redirect_to worker_tasks_path, alert: "Unable to apply for the task."
    end
  end
  def show
    @application = current_user.applications.find(params[:id])
  end
  def approve
    @application = Application.find(params[:id])
    @application.update(status: "approved")
    redirect_to worker_applications_path, notice: "Task has been approved."
  end

  def reject
    @application = current_user.applications.find(params[:id])
    @application.update(status: "rejected")
    redirect_to worker_applications_path, noticend
  end
  private
  def application_params
    params.expect(application: [ :id ])
  end
end
# > User.worker.first.applications.new(task_id: 5)
