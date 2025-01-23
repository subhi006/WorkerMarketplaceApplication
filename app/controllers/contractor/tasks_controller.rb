class Contractor::TasksController < ApplicationController
  def index
    @task = Task.all
  end
  def new
    @task = Task.new
  end
  def create
    @task = Task.new(task_params)
    if @task.save
      @task=Task.last
      redirect_to contractor_task_path
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
    params.expect(task: [ :category, :duration, :location, :company, :description, :salary ])
  end
end
