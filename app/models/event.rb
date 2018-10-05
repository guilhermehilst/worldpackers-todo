require 'csv'

class Event < ApplicationRecord
  belongs_to :task

  validates :event_type, presence: true
  validates :payload, presence: true

  def self.to_csv(options = {})
    CSV.generate(options) do |csv_file|
      csv_file << csv_header_row

      all.each do |event|
        csv_file << [ event.payload['user_email'],
                      event.payload['colour'],
                      event.payload['phrase'],
                      event.payload['completed_at'] ]
      end
    end
  end

  def self.csv_header_row
    %w(UserEmail Colour Phrase Completed_at)
  end
end
