class Worker::TasksController < ApplicationController
  def index
    @task = Task.search(params[:search])
  end

  def show
    @task = Task.find(params[:id])
  end

  # def apply
  #   @task = Task.find(params[:id])
  #   current_user.apply(@task)
  # end
end
