class Fidref < ActiveRecord::Migration[8.0]
  def change
    add_reference :friends, :friend_id, foreign_key: { to_table: :users }
  end
end
