class RemoveDailyDigestFromUser < ActiveRecord::Migration[8.0]
  def change
    remove_column :users, :daily_digest
  end
end
