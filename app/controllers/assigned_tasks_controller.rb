class AssignedTasksController < ApplicationController
  def index
    @tasks= Task.where(contractor: current_user, work_status: "start").includes(:applications)
  end
  def show
    @task = Task.find(params[:id])
    @applications = @task.applications.includes(worker: [ :profile ])
  end
end
