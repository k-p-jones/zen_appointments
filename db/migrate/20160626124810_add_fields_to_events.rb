class AddFieldsToEvents < ActiveRecord::Migration
  def change
  	add_column :events, :location, :string
  	add_column :events, :notes, :text
  end
end
