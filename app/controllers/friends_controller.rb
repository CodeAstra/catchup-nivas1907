class FriendsController < ApplicationController
  def index
    @friends_ids=Friendship.where(sender_id: current_user.id, status: "accepted").pluck(:reciver_id)+Friendship.where(reciver_id: current_user.id, status: "accepted").pluck(:sender_id)
    @pending_list=Friendship.where(reciver_id: current_user, status: "pending")
    @users=User.where(id: @friends_ids)
    @pending_list_count=@pending_list.count
  end

  def show
  end

  def search
    @input=params[:search]
      @friends_ids=Friendship.where(sender_id: current_user.id, status: "accepted").pluck(:reciver_id)+Friendship.where(reciver_id: current_user.id, status: "accepted").pluck(:sender_id)
      @users=User.where(id: @friends_ids)
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
    @user=User.where.not(id: current_user.id).where.not(id: current_user.friendships.where(status: "accepted").pluck(:reciver_id))
  end

  def create
    @user=User.find(params[:fid])
    Friendship.create(reciver_id: params[:fid], sender_id: current_user.id, status: "pending")
    respond_to do |format|
      format.html { redirect_to new_friend_path, notice: "Friend request sent." }
      format.turbo_stream { flash[:notice] = "Friend request sent." }
    end
  end
end
