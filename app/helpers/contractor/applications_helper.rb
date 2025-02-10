module Contractor::ApplicationsHelper
  def name(application)
    application.worker.full_name
  end
  def experience(application)
    application.worker.profile.experience
  end
  def number(application)
    application.worker.phone_number
  end
end
