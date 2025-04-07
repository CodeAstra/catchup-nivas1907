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
  def notfriend(id)
    val=Friend.exists?(user_id: current_user.id, friend_id: id)&&Friend.exists(user_id: id, friend_id: current_user.id)
    val
  end
end
