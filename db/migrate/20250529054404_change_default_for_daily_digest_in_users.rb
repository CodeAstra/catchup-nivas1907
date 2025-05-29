class ChangeDefaultForDailyDigestInUsers < ActiveRecord::Migration[7.1]
  def change
    change_column_default :users, :daily_digest, from: nil, to: false
  end
end
