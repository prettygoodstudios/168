class AddWeekIdToDays < ActiveRecord::Migration[5.1]
  def change
    add_column :days, :week_id, :integer
  end
end
