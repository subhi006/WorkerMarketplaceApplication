# require "sidekiq"
class HelloJob
  queue_as :default
  def perform
    puts "hello from inside a backgroung job!"
  end
end
puts "hello from out side the job!"


HelloJob.perform_async
puts "hello from after the job"
