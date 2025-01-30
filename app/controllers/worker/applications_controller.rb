class Worker::ApplicationsController < ApplicationController
  before_action :authenticate_user!
  def index
    @applications = current_user.applications
  end
  def create
    if current_user.profile
      @task = Task.find(params[:task_id])
      @application = @task.applications.build(worker: current_user, status: "applied")
      if @application.save
        UserMailer.with(task: @task).new_application_email.deliver_now
        redirect_to worker_tasks_path, notice: "You have successfully applied for the task."
      else
        redirect_to worker_tasks_path, alert: "Unable to apply for the task."
      end
    else
      redirect_to root_path, alert: "create Profile first."
    end
  end
  def show
    @application = current_user.applications.find(params[:id])
  end

  private
  def application_params
    params.expect(application: [ :id ])
  end
end
# > User.worker.first.applications.new(task_id: 5)
