class NullToTitleDescriptionInPosts < ActiveRecord::Migration[8.0]
  def change
    change_column_null :posts, :title, false
    change_column_null :posts, :description, false
  end
end
