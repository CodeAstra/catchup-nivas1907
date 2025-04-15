class RemoveStatusFromFriendship < ActiveRecord::Migration[8.0]
  def change
    remove_column :friendships, :status
  end
end
