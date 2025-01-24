class Worker::TasksController < ApplicationController
  def index
    @task =  Task.available
  end

  def show
    @task = Task.find(params[:id])
  end
end
