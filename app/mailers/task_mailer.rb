class TaskMailer < ApplicationMailer
  default to: -> { User.worker.pluck(:email) },
  from: "samishra@bestpeers.in"

   def new_task_created_email
    @task = params[:task]
    mail(subject: "New Task: #{@task.category.name}")
   end

  # def worker_selected_email(worker, task)
  #   @worker = worker
  #   @task = task
  #   mail(to: @worker.email, subject: "You have been selected for a task")
  # end
  # def new_task_created_email
  #   @user = params[:user]
  #   @task = params[:task]
  #   @url  = "http://localhost:3000/login"
  #   @user.each do |user|
  #      mail(to: user.email, subject: "Welcome to My company,Your application approved")
  #   end
  # end
end
