class AddMinstartToEvents < ActiveRecord::Migration[5.1]
  def change
    add_column :events, :minstart, :integer
  end
end
