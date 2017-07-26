class AddDayIdToEvents < ActiveRecord::Migration[5.1]
  def change
    add_column :events, :day_id, :integer
  end
end
