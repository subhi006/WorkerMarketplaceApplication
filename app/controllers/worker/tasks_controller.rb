class Worker::TasksController < ApplicationController
  def index
    @q =  Task.ransack(params[:q])
    @task = @q.result
    # @task = Task.search(params[:search])
  end

  def show
    @task = Task.find(params[:id])
  end

  # def apply
  #   @task = Task.find(params[:id])
  #   current_user.apply(@task)
  # end
end
