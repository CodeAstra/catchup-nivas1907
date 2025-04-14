class ChangeFriendToFriendship < ActiveRecord::Migration[8.0]
  def change
    rename_table :friends, :friendships
  end
end
