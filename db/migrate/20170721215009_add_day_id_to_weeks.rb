class AddDayIdToWeeks < ActiveRecord::Migration[5.1]
  def change
    add_column :weeks, :day_id, :integer
  end
end
