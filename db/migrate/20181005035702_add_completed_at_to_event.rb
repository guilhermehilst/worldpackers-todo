class AddCompletedAtToEvent < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :completed_at, :datetime
  end
end
