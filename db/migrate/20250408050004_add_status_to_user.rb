class AddStatusToUser < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :status, :string, default: "public"
  end
end
