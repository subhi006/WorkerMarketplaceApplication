class Contractor::TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_contractor, only: [ :show, :edit, :update, :destroy ]
  after_action :send_notification, only: [ :task_post ]
  def index
    @tasks = current_user.tasks.application_count
    if @tasks.nil?
      flash[:alert] = "Task not found."
      redirect_to contractor_tasks_path
    end
  end
  def show
    authorize! :read, @task
    @application = @task.applications
  end
  def new
    @task = Task.new
    authorize! :create, @task
    @categories = Category.all
  end
  def create
    @task = Task.new(task_params)
    authorize! :create, @task
    if @task.save
        redirect_to contractor_tasks_path, notice: "Task was successfully created."
    else
      render :new, notice: "retry to create task"
    end
  end

  def edit
    authorize! :update, @task
  end

  def update
    @task =Task.find(params[:id])
    authorize! :update, @task
    if @task.update(update_task_params)
      redirect_to contractor_tasks_path
    end
  end

  def task_post
        @task = Task.find(params[:id])
        @task.status="available"
        authorize! :post_task, @task
        if @task.save
         redirect_to contractor_tasks_path
        end
  end

  def destroy
    authorize! :destroy, @task
    if @task.destroy!
      redirect_back contractor_tasks_path, notice: "Task was successfully destroyed"
    end
  end

  private
  def set_contractor
    @task = Task.find(params[:id])
  end
  def task_params
    data=params.expect(task: [ :category, :duration, :location, :company, :description, :salary, :sift, :sift_hours, :job_mode, :experience, :number_of_position ])
    data[:category]=Category.find(data[:category].to_i)
    data[:contractor]=current_user
    data
  end
  def update_task_params
    params.expect(task: [ :duration, :location, :company, :description, :salary, :sift, :sift_hours, :job_mode, :experience, :number_of_position ])
  end

  def send_notification
    CreateNotificationJob.perform_now(@task, current_user)
    NewTaskPostEmailJob.perform_later(@task)
  end
end
