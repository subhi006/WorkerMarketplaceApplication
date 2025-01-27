class TaskMailer < ApplicationMailer
  def worker_selected_email(worker, task)
    @worker = worker
    @task = task
    mail(to: @worker.email, subject: "You have been selected for a task")
  end
end
