FactoryBot.define do
  factory :event do
    task
    event_type { 'event type' }
    completed_at { Time.zone.now - 10.minutes }
    payload { { colour: 'nice color', phrase: 'nice phrase' } }
  end
end
