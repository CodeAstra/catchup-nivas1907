class Friend < ActiveRecord::Migration[8.0]
  def change
    add_column :friends, :friend_id, :integer
  end
end
