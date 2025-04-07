class Deletecol < ActiveRecord::Migration[8.0]
  def change
    remove_column :friends, :friend_id, :integer
  end
end
