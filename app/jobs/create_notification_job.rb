class CreateNotificationJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Do something later
    def perform(task, user)
      Notification.create!(user_id: user.id, task_id: task.id, message: "new task was created", status: "unread")
      flash[:alert] = "New Task was created"
    end
  end
end
