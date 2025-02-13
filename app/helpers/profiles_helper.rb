module ProfilesHelper
  def status(status)
        if status.work_status.eql?("open")
          "Open to work"
        else
          "Currently working"
        end
  end
  def user_company(profile)
    profile.user.applications.approved.first.task.company
  end
  def user_category(profile)
    profile.user.applications.approved.first.task.category.name
  end
end
