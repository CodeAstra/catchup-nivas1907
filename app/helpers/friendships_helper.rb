module FriendshipsHelper
  def sentrequest(id)
   current_user.sent.pending.exists?(reciver_id: id)
  end

  def checkf(id)
    !current_user.accepted_friends_ids.include?(id)
  end

  def pendingrequest(id)
    current_user.received.pending.exists?(sender_id: id)
  end

  def isfriend(id)
    current_user.accepted_friends_ids.include?(id)
  end

  def pending_list_count
    current_user.pending_friends_ids.count
  end

  def getid(id, status)
    if status=="received"
      current_user.received.pending.where(sender_id: id).first
    else
      current_user.sent.rejected.where(reciver_id: id).first
    end
  end
end
