module AssignedTasksHelper
  def isassigned(task)
   if task.applications.approved.first.present?
     true
   else
      false
   end
  end
  def work_progress(application)
    application.worker.profile.work_status
  end
end
