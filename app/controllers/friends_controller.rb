class FriendsController < ApplicationController
  def index
    @pending_list_ids=current_user.pending_friends
    @confirmed_ids=current_user.accepted_friends
    @users=User.where(id: @confirmed_ids)
    @pending_list=User.where(id: @pending_list_ids)
    @pending_list_count=@pending_list.count
  end

  def show
  end

  def search
    @input=params[:search]
    @confirmed_ids=current_user.accepted_friends
    @users=User.where(id: @confirmed_ids)
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
    @user=User.where.not(id: current_user.id).where.not(id: current_user.accepted_friends)
  end

  def create
    @user=User.find(params[:fid])
    if  Friendship.rejected.exists?(reciver_id: params[:fid], sender_id: current_user.id)
      id=Friendship.rejected.where(reciver_id: params[:fid], sender_id: current_user.id).first.id
      Friendship.find(id).update_status(Friendship.friendship_statuses[:pending])
      respond_to do |format|
        format.html { redirect_to new_friend_path }
        format.turbo_stream { flash[:notice] = "Friend request sent." }
      end
    else
      Friendship.create(reciver_id: params[:fid], sender_id: current_user.id, friendship_status: Friendship.friendship_statuses[:pending])
      respond_to do |format|
        format.html { redirect_to new_friend_path }
        format.turbo_stream { flash[:notice] = "Friend request sent." }
      end
    end
  end
end
