class AddEventIdToDays < ActiveRecord::Migration[5.1]
  def change
    add_column :days, :event_id, :integer
  end
end
