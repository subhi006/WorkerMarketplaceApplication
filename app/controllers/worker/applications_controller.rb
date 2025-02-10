class Worker::ApplicationsController < ApplicationController
  before_action :authenticate_user!
  after_action :new_application_email, only: [ :create ]
  def index
    authorize! :read, Application
    @applications = Application.where(worker: current_user).includes(task: [ :category ])
  end

  def create
    if current_user.profile
      @task = Task.find(params[:task_id])
      authorize! :create, Application
      @application = @task.applications.new(worker: current_user, status: "applied")
      if @application.save
        flash[:success] = "Application submitted successfully"
        redirect_to worker_tasks_path
      else
        redirect_to worker_tasks_path, alert: "Unable to apply for the task."
      end
    else
      redirect_to root_path, alert: "create Profile first."
    end
  end
  def show
    authorize! :read, Application
    @application = current_user.applications.find(params[:id])
  end

  private
  def application_params
    params.expect(application: [ :id ])
  end
  def new_application_email
    NewApplicationEmailJob.perform_later(@task)
  end
end
# > User.worker.first.applications.new(task_id: 5)
