class NullToUserIdInUser < ActiveRecord::Migration[8.0]
  def change
    change_column_null :likes, :user_id, false
  end
end
