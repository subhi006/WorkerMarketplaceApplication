class NewTaskPostEmailJob < ApplicationJob
  queue_as :default

  def perform(task)
    TaskMailer.with(task: task).new_task_created_email.deliver_later
    # Do something later
  end
end
