class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.string :name
      t.decimal :start
      t.decimal :end
      t.timestamps
    end
  end
end
