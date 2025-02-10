module ApplicationHelper
  def formate_date(date)
    date.strftime("%d %b %Y")
  end
  def formate_time(date)
    date.strftime("%H:%M")
  end
  def formate_date_time(date)
    date.strftime("%m/%d/%Y  %H:%M")
  end
  def category(task)
    task.category.name
  end
  def task_applied(task)
    task.id.in? current_user.applications.pluck(:task_id)
  end
end
