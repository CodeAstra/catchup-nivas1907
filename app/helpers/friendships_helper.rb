module FriendshipsHelper
  def check(id)
   @friend=Friendship.all
   if @friend.pending.exists?(sender_id: current_user.id, reciver_id: id)
     true
   else
      false
   end
  end
  def checkf(id)
    @friend=Friendship.all
    val=Friendship.accepted.exists?(sender_id: current_user.id, reciver_id: id)||Friendship.accepted.exists?(sender_id: id, reciver_id: current_user.id)
    if val
      false
    else
      true
    end
  end
  def pendingrequest(id)
    val=Friendship.pending.exists?(sender_id: id, reciver_id: current_user.id)
    val
  end
  def getid(id)
    Friendship.where(sender_id: id, reciver_id: current_user.id).pending.first
  end
end
