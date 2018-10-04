class TrackingEventWorker
  include Sidekiq::Worker

  def perform(task_id)
    event = EventCreator.call(task_id)
    UserMailer.task_completion(event.id).deliver_now
  end
end
