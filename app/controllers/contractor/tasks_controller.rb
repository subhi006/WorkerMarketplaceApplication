class Contractor::TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_contractor, only: [ :show, :edit, :update, :destroy, :work_start, :task_post ]
  after_action :task_post_notification, only: [ :task_post ]
  # after_action :work_start_notification, only: [ :work_start ]

  def index
    authorize! :read, Task
    @tasks = Task.where(contractor: current_user).application_count.order(updated_at: :desc)
    if @tasks.nil?
      flash[:alert] = "Task not found."
      redirect_to contractor_tasks_path
    end
  end
  def show
    authorize! :read, Task
    @application = @task.applications
  end
  def new
    @task = Task.new
    authorize! :create, Task
    @categories = Category.all
  end
  def create
    @task = Task.new(task_params)
    authorize! :create, Task
    if @task.save
        redirect_to contractor_tasks_path, notice: "Task was successfully created."
    else
      render :new, notice: "retry to create task"
    end
  end

  def edit
    authorize! :update, Task
  end

  def update
    authorize! :update, Task
    if @task.update(update_task_params)
      redirect_to contractor_tasks_path
    end
  end

  def task_post
    @task.status="available"
    authorize! :post_task, Task
    if @task.save
      redirect_to contractor_tasks_path
    end
  end
  def work_start
    authorize! :work_start, Task
    if @task.update(work_status: "start", start_date: Date.today)
      redirect_to assigned_task_path(@task), notice: "Task has been started."
    end
  end
  def destroy
    authorize! :destroy, Task
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

  def task_post_notification
    CreateNotificationJob.perform_now(@task, current_user)
    NewTaskPostEmailJob.perform_later(@task)
  end
end
