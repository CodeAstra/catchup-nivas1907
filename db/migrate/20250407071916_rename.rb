class Rename < ActiveRecord::Migration[8.0]
  def change
    rename_column :friends, :friend_id_id , :friend_id
  end
end
