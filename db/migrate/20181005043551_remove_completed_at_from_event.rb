class RemoveCompletedAtFromEvent < ActiveRecord::Migration[5.2]
  def change
    remove_column :events, :completed_at, :datetime
  end
end
