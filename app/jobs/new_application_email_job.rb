class NewApplicationEmailJob < ApplicationJob
  queue_as :default

  def perform(task)
    UserMailer.with(task: task).new_application_email.deliver_later
    # Do something later
  end
end
