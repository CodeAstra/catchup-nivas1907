module AccountHelper
  def pendingrequest(id)
    val=Friendship.pending.exists?(sender_id: id, reciver_id: current_user.id)
    val
  end
  def getid(id)
    Friendship.where(sender_id: id, reciver_id: current_user.id).pending.first
  end
  def sentrequest(id)
    val=Friendship.pending.exists?(sender_id: current_user.id, reciver_id: id)
    val
  end
  def isfriend(id)
    val=current_user.accepted_friends.include?(id)
    val
  end
  def canishow(id)
    ids=current_user.accepted_friends
    # user seeing his account page
    checker1= (id==current_user.id)
    # public account
    checker2= User.find(id).public_state?
    # private
    checker3= (User.find(id).private_state? && current_user.accepted_friends.include?(id))
    # protected
    checker4=(User.find(id).protected_state? && (Friendship.accepted.exists?(sender_id: ids, reciver_id: id)||Friendship.accepted.exists?(sender_id: id, reciver_id: ids)) ||Friendship.accepted.exists?(sender_id: current_user.id, reciver_id: id)||Friendship.accepted.exists?(sender_id: id, reciver_id: current_user.id))
    val=checker1||checker2||checker3||checker4
    val
  end
end
