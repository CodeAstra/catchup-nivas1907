class NullToStatus < ActiveRecord::Migration[8.0]
  def change
    change_column_null :friendships, :friendship_status, false
  end
end
