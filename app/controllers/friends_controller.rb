class FriendsController < ApplicationController
  def index
    @pending_list=current_user.pending_friends
    @users=current_user.friends
    @pending_list_count=@pending_list.count
  end

  def show
  end

  def search
    @input=params[:search]
      @users=current_user.friends
      @users=@users.where("users.username LIKE ?", [ "%#{@input}%" ]).or(@users.where("email LIKE ? ", "%#{@input}%"))
      render "index"
  end
  def search2
    @input=params[:search]
    @user=User.where.not(id: current_user.id).where.not(id: current_user.friendships.where(status: "accepted").pluck(:reciver_id))
      @user=@user.where("username LIKE ? ", "%#{@input}%").or(@user.where("email LIKE ? ", "%#{@input}%"))
      render "new"
  end

  def new
    @user=User.where.not(id: current_user.id).where.not(id: current_user.friends.ids)
  end

  def create
    @user=User.find(params[:fid])
    if  Friendship.exists?(reciver_id: params[:fid], sender_id: current_user.id, friendship_status: 0)
      id=Friendship.where(reciver_id: params[:fid], sender_id: current_user.id, friendship_status: 0).first.id
      Friendship.find(id).updatestate(2)
      respond_to do |format|
        format.html { redirect_to new_friend_path, notice: "Friend request sent." }
        format.turbo_stream { flash[:notice] = "Friend request sent." }
      end
    else
      Friendship.create(reciver_id: params[:fid], sender_id: current_user.id, friendship_status: 2)
      respond_to do |format|
        format.html { redirect_to new_friend_path, notice: "Friend request sent." }
        format.turbo_stream { flash[:notice] = "Friend request sent." }
      end
    end
  end
end
