class RenameColumnsOfFriendship < ActiveRecord::Migration[8.0]
  def change
    rename_column :friendships, :friend_id, :reciver_id
    rename_column :friendships, :user_id, :sender_id
  end
end
