class AddMinendToEvents < ActiveRecord::Migration[5.1]
  def change
    add_column :events, :minend, :integer
  end
end
