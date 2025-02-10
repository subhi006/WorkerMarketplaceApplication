class SendRejectMailSmsJob < ApplicationJob
  queue_as :default

  def perform(user)
    UserMailer.with(user: user).rejected_application_email.deliver_later
    TwilioClient.new.send_text(user, " we regret to inform you that we have decided to move forward with other candidates at this timeWe wish you the best in your career journey.Best regards,JobYatra")
    # Do something later
  end
end
