class AddDailsyDigestToUser < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :daily_digest, :boolean, default: false
  end
end
