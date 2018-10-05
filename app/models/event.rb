class Event < ApplicationRecord
  belongs_to :task

  validates :event_type, presence: true
  validates :payload, presence: true
  validates :completed_at, presence: true
end
