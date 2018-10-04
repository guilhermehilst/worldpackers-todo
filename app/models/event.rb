class Event < ApplicationRecord
  belongs_to :task

  validates :type, presence: true
  validates :payload, presence: true
end
