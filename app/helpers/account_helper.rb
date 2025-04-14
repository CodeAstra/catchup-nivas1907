module AccountHelper
  def pendingrequest(id)
    val=Friendship.exists?(sender_id: id, reciver_id: current_user.id, status: "pending")
    val
  end
  def getid(id)
    Friendship.where(sender_id: id, reciver_id: current_user.id, status: "pending").first
  end
  def sentrequest(id)
    val=Friendship.exists?(sender_id: current_user.id, reciver_id: id, status: "pending")
    val
  end
  def isfriend(id)
    val=Friendship.exists?(sender_id: current_user.id, reciver_id: id, status: "accepted")||Friendship.exists?(sender_id: id, reciver_id: current_user.id, status: "accepted")
    val
  end
  def canishow(id)
    ids=Friendship.where(sender_id: current_user.id, status: "accepted").pluck(:reciver_id)+Friendship.where(reciver_id: current_user.id, status: "accepted").pluck(:sender_id)
    val=id==current_user.id||User.find(id).public_state?||(User.find(id).private_state? && Friendship.exists?(sender_id: current_user.id, reciver_id: id, status: "accepted")||Friendship.exists?(sender_id: id, reciver_id: current_user.id, status: "accepted"))||(User.find(id).protected_state? && (Friendship.exists?(sender_id: ids, reciver_id: id, status: "accepted")||Friendship.exists?(sender_id: id, reciver_id: ids, status: "accepted")) ||Friendship.exists?(sender_id: current_user.id, reciver_id: id, status: "accepted")||Friendship.exists?(sender_id: id, reciver_id: current_user.id, status: "accepted"))
    val
  end
end
