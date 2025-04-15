class NullToreciver < ActiveRecord::Migration[8.0]
  def change
    change_column_null :friendships, :reciver_id, false
  end
end
