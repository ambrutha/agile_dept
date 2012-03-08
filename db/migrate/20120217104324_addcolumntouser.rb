class Addcolumntouser < ActiveRecord::Migration
  def up
	add_column :orders, :user_id, :integer
  end

  def down
	remove_column :orders, :user_id, :integer
  end
end
