class Event < ApplicationRecord
  belongs_to :task

  validates :event_type, presence: true
  validates :payload, presence: true
end
