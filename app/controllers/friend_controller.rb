class FriendController < ApplicationController
  def index
    @friends_list=Friend.where(user_id: current_user.id , status: "accepted")+Friend.where(friend_id: current_user.id , status: "accepted")
    @pending_list=Friend.where(friend_id: current_user, status: "pending")
    @pending_list_count=@pending_list.count
  end

  def show
  end

  def new
    @user=User.where.not(id: current_user.id)
  end

  def create
    Friend.create(friend_id: params[:fid], user_id: current_user.id, status: "pending")
    
  end
end
