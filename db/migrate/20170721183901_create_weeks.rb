class CreateWeeks < ActiveRecord::Migration[5.1]
  def change
    create_table :weeks do |t|
      t.date :start
      t.integer :user_id
      t.timestamps
    end
  end
end
