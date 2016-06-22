class CreateOptions < ActiveRecord::Migration
  def change
    create_table :options do |t|
      t.string :calender_start_time
      t.string :calender_end_time
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
