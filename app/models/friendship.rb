class Friendship < ApplicationRecord
  belongs_to :sender, class_name: "User", foreign_key: "sender_id"
  belongs_to :reciver, class_name: "User", foreign_key: "reciver_id"
  enum :friendship_status, { rejected: 0, accepted: 1,  pending: 2 }
  def updatestate(status)
    update(friendship_status: status)
  end
end
