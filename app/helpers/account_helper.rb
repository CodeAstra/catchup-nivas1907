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
    val=current_user.friends.ids.include?(id)
    val
  end
  def canishow(id)
    ids=current_user.friends.ids
    # user seeing his account page
    checker1= (id==current_user.id)
    # public account
    checker2= User.find(id).public_state?
    # private
    checker3= (User.find(id).private_state? && current_user.friends.ids.include?(id))
    # protected
    checker4=(User.find(id).protected_state? && (Friendship.exists?(sender_id: ids, reciver_id: id, status: "accepted")||Friendship.exists?(sender_id: id, reciver_id: ids, status: "accepted")) ||Friendship.exists?(sender_id: current_user.id, reciver_id: id, status: "accepted")||Friendship.exists?(sender_id: id, reciver_id: current_user.id, status: "accepted"))
    val=checker1||checker2||checker3||checker4
    val
  end
end
