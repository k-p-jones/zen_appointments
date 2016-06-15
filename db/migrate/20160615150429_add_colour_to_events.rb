class AddColourToEvents < ActiveRecord::Migration
  def change
  	add_column :events, :colour, :string
  end
end
