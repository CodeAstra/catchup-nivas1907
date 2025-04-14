module FriendsHelper
  def check(id)
   @friend=Friendship.all
   if @friend.exists?(sender_id: current_user.id, reciver_id: id, status: "pending")
     true
   else
      false
   end
  end
  def checkf(id)
    @friend=Friendship.all
    val=Friendship.exists?(status: :"accepted", sender_id: current_user.id, reciver_id: id)||Friendship.exists?(status: :"accepted", sender_id: id, reciver_id: current_user.id)
    if val
      false
    else
      true
    end
  end
  def pendingrequest(id)
    val=Friendship.exists?(sender_id: id, reciver_id: current_user.id, status: "pending")
    val
  end
  def getid(id)
    Friendship.where(sender_id: id, reciver_id: current_user.id, status: "pending").first
  end
end
