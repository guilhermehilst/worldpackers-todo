class Task < ApplicationRecord
  belongs_to :user
  has_one :event, dependent: :destroy

  validates :title, presence: true
end
