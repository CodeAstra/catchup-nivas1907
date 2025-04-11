class FriendsController < ApplicationController
  def index
    @friends_ids=Friend.where(user_id: current_user.id, status: "accepted").pluck(:friend_id)+Friend.where(friend_id: current_user.id, status: "accepted").pluck(:user_id)
    @pending_list=Friend.where(friend_id: current_user, status: "pending")
    @users=User.where(id: @friends_ids)
    @pending_list_count=@pending_list.count
  end

  def show
  end

  def search
    @input=params[:search]
      @friends_ids=Friend.where(user_id: current_user.id, status: "accepted").pluck(:friend_id)+Friend.where(friend_id: current_user.id, status: "accepted").pluck(:user_id)
      @users=User.where(id: @friends_ids)
      @users=@users.where("users.username LIKE ?", [ "%#{@input}%" ]).or(@users.where("email LIKE ? ", "%#{@input}%"))
      render "index"
  end
  def search2
    @input=params[:search]
    @user=User.where.not(id: current_user.id).where.not(id: current_user.friends.where(status: "accepted").pluck(:friend_id))
      @user=@user.where("username LIKE ? ", "%#{@input}%").or(@user.where("email LIKE ? ", "%#{@input}%"))
      render "new"
  end

  def new
    @user=User.where.not(id: current_user.id).where.not(id: current_user.friends.where(status: "accepted").pluck(:friend_id))
  end

  def create
    @user=User.find(params[:fid])
    Friend.create(friend_id: params[:fid], user_id: current_user.id, status: "pending")
    respond_to do |format|
      format.html { redirect_to new_friend_path }
      format.turbo_stream
    end
  end
end
