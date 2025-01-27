class Contractor::TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_contractor, only: [ :show, :edit, :update, :destroy ]
  def index
    @task = Task.all
  end
  def new
    @task = [ Task.new, Category.all ]
  end
  def create
    # debugger
    @task = Task.new(task_params)
    if @task.save
      # @task=Task.last
      redirect_to contractor_tasks_path
    authorize! :create, @task
    if @task.save
      # @task=Task.last
      redirect_to contractor_tasks_path, notice: "Task was successfully created."
    else
      render :new, notice: "retry to create task"
    end
  end
  def show
    @task = Task.find(params[:id])
  end
  def edit
    @task = Task.find(params[:id])
  end
  def update
    @task =Task.find(params[:id])
    if @task.update(task_params)
      redirect_to contractor_tasks_path
    end
  end

  private
  def task_params
    data=params.expect(task: [ :category, :duration, :location, :company, :description, :salary ])
    data[:category]=Category.find(data[:category].to_i)
    data[:user_id]=current_user.id
    authorize! :read, @task
  end
  def edit
  end
  def update
    authorize! :update, @task
    if @task.update(task_params)
      redirect_to contractor_tasks_path, notice: "Task was succeddfully updated."
    else
      render :edit, notice: "retry to update task"
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
>>>>>>> c8b23a8 (create task Application feature and cancan gem setup)
    data
  end
end
