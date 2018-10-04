class TrackingEventWorker
  include Sidekiq::Worker

  def perform(task_id)
    EventCreator.call(task_id)
  end
end
