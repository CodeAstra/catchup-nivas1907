class Friendship < ApplicationRecord
  belongs_to :sender, class_name: "User", foreign_key: "sender_id"
  belongs_to :reciver, class_name: "User", foreign_key: "reciver_id"

  enum :friendship_status, { pending: 0, accepted: 1, rejected: 2 }

  validate :sender_and_receiver_cannot_be_same

  private

  def sender_and_receiver_cannot_be_same
    if sender_id == reciver_id
      errors.add("reciver can't be the same as sender")
    end
  end
end
