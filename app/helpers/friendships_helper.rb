module FriendshipsHelper
  def check(id)
   current_user.sent.pending.exists?(reciver_id: id)
  end

  def checkf(id)
    !current_user.accepted_friends_ids.include?(id)
  end

  def pendingrequest(id)
    current_user.received.pending.exists?(sender_id: id)
  end

  def getid(id)
    current_user.received.pending.where(sender_id: id).first
  end
end
