class Worker::TasksController < ApplicationController
  before_action :authenticate_user!

  def index
    authorize! :read, Task
    @q =  Task.available.includes(:category).ransack(params[:q])
    @tasks = @q.result.order(updated_at: :desc)
  end

  def show
    @task = Task.find(params[:id])
    authorize! :read, Task
  end
end
