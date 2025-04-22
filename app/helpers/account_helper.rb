module AccountHelper
  def pending_request(id)
    current_user.received.pending.exists?(sender_id: id)
  end

  def getid(id, status)
    if status=="received"
      current_user.received.pending.where(sender_id: id).first
    else
      current_user.sent.rejected.where(reciver_id: id).first
    end
  end

  def sent_request(id)
    current_user.sent.pending.exists?(reciver_id: id)
  end

  def stranger(id)
    current_user.accepted_friends_ids.exclude?(id)
  end

  def canishow(id)
    (id==current_user.id)||User.find(id).public_state?||(User.find(id).private_state? && current_user.accepted_friends_ids.include?(id))||(User.find(id).protected_state? && (current_user.accepted_friends_ids.include?(id))|| (current_user.one_layer_friends_ids.include?(id)))
  end
end
