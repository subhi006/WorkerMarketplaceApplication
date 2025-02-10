class SendApproveMailSmsJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Do something later
    UserMailer.with(user: @application.worker).approved_application_email.deliver_later
    TwilioClient.new.send_text(@application.worker, "We are pleased to inform you that your application has been approved. Congratulations! Best regards,JobYatra")
  end
end
