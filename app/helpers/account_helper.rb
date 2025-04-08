module AccountHelper
  def pendingrequest(id)
    val=Friend.exists?(user_id: id, friend_id: current_user.id, status: "pending")
    val
  end
  def getid(id)
    Friend.where(user_id: id, friend_id: current_user.id, status: "pending").first
  end
  def sentrequest(id)
    val=Friend.exists?(user_id: current_user.id, friend_id: id, status: "pending")
    val
  end
  def isfriend(id)
    val=Friend.exists?(user_id: current_user.id, friend_id: id, status: "accepted")||Friend.exists?(user_id: id, friend_id: current_user.id, status: "accepted")
    val
  end
  def canishow(id)
    ids=Friend.where(user_id: current_user.id , status: "accepted").pluck(:friend_id)+Friend.where(friend_id: current_user.id , status: "accepted").pluck(:user_id)
    val=id==current_user.id||User.find(id).public_state?||(User.find(id).private_state? && Friend.exists?(user_id: current_user.id, friend_id: id, status: "accepted")||Friend.exists?(user_id: id, friend_id: current_user.id, status: "accepted"))||(User.find(id).protected_state? && (Friend.exists?(user_id: ids, friend_id: id, status: "accepted")||Friend.exists?(user_id: id, friend_id: ids, status: "accepted")) ||Friend.exists?(user_id: current_user.id, friend_id: id, status: "accepted")||Friend.exists?(user_id: id, friend_id: current_user.id, status: "accepted")  )
    val
  end
end
