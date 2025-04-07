module FriendHelper
  def check(id)
   @friend=Friend.all
   if @friend.exists?(friend_id: id, status: "pending")
     true
   else
      false
   end
  end
  def checkf(id)
    @friend=Friend.all
    val=Friend.exists?(status: :"accepted", user_id: current_user.id, friend_id: id)||Friend.exists?(status: :"accepted", user_id: id, friend_id: current_user.id)
    if val
      false
    else
      true
    end
  end
  def pendingrequest(id)
    val=Friend.exists?(user_id: id, friend_id: current_user.id, status: "pending")
    val
  end
  def getid(id)
    Friend.where(user_id: id, friend_id: current_user.id, status: "pending").first
  end
end
