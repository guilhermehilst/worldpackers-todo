class CreateEvent < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :type
      t.json :payload
      t.belongs_to :task

      t.timestamps
    end
  end
end
