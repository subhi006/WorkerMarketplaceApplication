class Contractor::TasksController < ApplicationController
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
    data
  end
end
