class Contractor::TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_contractor, only: [ :show, :edit, :update, :destroy ]
  def index
    @task = current_user.tasks.application_count
    if @task.nil?
      flash[:alert] = "Task not found."
      redirect_to contractor_tasks_path
    end
  end
  def show
  end
  def new
    @task = Task.new
    @categories = Category.all_present_category
  end
  def create
    # debugger
    @task = Task.new(task_params)
    authorize! :create, @task
    if @task.save
        redirect_to contractor_tasks_path, notice: "Task was successfully created."
    else
      render :new, notice: "retry to create task"
    end
  end

  def edit
  end

  def update
    @task =Task.find(params[:id])
    if @task.update(update_task_params)
      redirect_to contractor_tasks_path
    end
  end

  def task_post
        @task = Task.find(params[:id])
        @task.status="available"
        if @task.save
          TaskMailer.with(task: @task).new_task_created_email.deliver_later
          redirect_to contractor_tasks_path
        end
  end

  def destroy
    if @task.destroy!
      redirect_to contractor_tasks_path, notice: "Task was successfully destroyed"
    end
  end

  private
  def set_contractor
    @task = Task.find(params[:id])
  end
  def task_params
    data=params.expect(task: [ :category, :duration, :location, :company, :description, :salary, :sift, :sift_hours, :job_mode, :experience ])
    data[:category]=Category.find(data[:category].to_i)
    data[:contractor_id]=current_user.id
    data
  end
  def update_task_params
    params.expect(task: [ :duration, :location, :company, :description, :salary, :sift, :sift_hours, :job_mode, :experience ])
  end
end
