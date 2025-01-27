class Contractor::TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_contractor, only: [ :show, :edit, :update, :destroy ]
  def index
    @task = Task.all
  end
  def show
  end
  def new
    @task = Task.new
  end
  def create
    debugger
    @task = Task.new(task_params)
    authorize! :create, @task
    if @task.save
      # @task=Task.last
      redirect_to contractor_tasks_path, notice: "Task was successfully created."
    else
      render :new, notice: "retry to create task"
    end
  end
  def edit
  end
  def update
    @task =Task.find(params[:id])
    if @task.update(task_params)
      redirect_to contractor_tasks_path
    end
  end

  def destroy
    authorize! :destroy, @task
    redirect_to contractor_tasks_path, notice: "Task was successfully destroyed"
  end

  private
  def set_contractor
    @task = Task.find(params[:id])
  end
  def task_params
    data=params.expect(task: [ :category, :duration, :location, :company, :description, :salary, :sift, :sift_hours, :mood ])
    data[:category]=Category.find(data[:category].to_i)
    data[:contractor_id]=current_user.id
    data
  end
end
