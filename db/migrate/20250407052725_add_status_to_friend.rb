class AddStatusToFriend < ActiveRecord::Migration[8.0]
  def change
    add_column :friends, :status, :string
  end
end
