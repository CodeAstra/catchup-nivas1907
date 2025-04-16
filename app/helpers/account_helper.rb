module AccountHelper
  def pendingrequest(id)
    current_user.received.pending.exists?(sender_id: id)
  end

  def getid(id)
    current_user.recived.pending.where(sender_id: id).first
  end

  def sentrequest(id)
    current_user.sent.pending.exists?(reciver_id: id)
  end

  def isfriend(id)
    current_user.accepted_friends_ids.include?(id)
  end

  def canishow(id)
    ids=current_user.accepted_friends_ids
    # user seeing his account page
    checker1= (id==current_user.id)
    # public account
    checker2= User.find(id).public_state?
    # private
    checker3= (User.find(id).private_state? && current_user.accepted_friends_ids.include?(id))
    # protected
    checker4=(User.find(id).protected_state? && (Friendship.accepted.exists?(sender_id: ids, reciver_id: id)||Friendship.accepted.exists?(sender_id: id, reciver_id: ids)) ||Friendship.accepted.exists?(sender_id: current_user.id, reciver_id: id)||Friendship.accepted.exists?(sender_id: id, reciver_id: current_user.id))
    val=checker1||checker2||checker3||checker4
    val
  end
end
