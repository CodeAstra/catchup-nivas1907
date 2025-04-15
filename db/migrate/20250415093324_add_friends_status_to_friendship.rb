class AddFriendsStatusToFriendship < ActiveRecord::Migration[8.0]
  def change
    add_column :friendships, :friendship_status, :integer, default: 0
  end
end
