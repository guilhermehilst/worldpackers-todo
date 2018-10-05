FactoryBot.define do
  factory :event do
    task
    event_type { 'event type' }
    payload { { colour: 'nice color', phrase: 'nice phrase' } }
  end
end
