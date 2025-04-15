class Friendship < ApplicationRecord
  belongs_to :sender, class_name: "User", foreign_key: "sender_id"
  belongs_to :reciver, class_name: "User", foreign_key: "reciver_id"
  def updatestate(state)
    update(status: state)
  end
end
