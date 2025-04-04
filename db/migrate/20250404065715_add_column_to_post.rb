class AddColumnToPost < ActiveRecord::Migration[8.0]
  def change
    add_column :posts, :title, :string
    add_column :posts, :description, :string
  end
end
