module Worker::TasksHelper
  def availability(task)
    task.current_status.eql?("Available")
  end
end
