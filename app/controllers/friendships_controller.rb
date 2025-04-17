class FriendshipsController < ApplicationController
  before_action :authenticate_user!
  def index
    @users=User.where(id: current_user.accepted_friends_ids)
    @pending_list_count=current_user.pending_friends_ids.size
  end

  def new
    @user=User.where.not(id: current_user.id).where.not(id: current_user.accepted_friends_ids)
  end

  def create
      Friendship.create(reciver_id: params[:fid], sender_id: current_user.id, friendship_status: Friendship.friendship_statuses[:pending])
      respond_to do |format|
        format.html { redirect_to new_friend_path }
        format.turbo_stream { flash[:notice] = "Friend request sent." }
      end
  end

  def update
    if Friendship.find(params[:id]).update_status(params[:status].to_i)
      respond_to do |format|
        format.html { redirect_to friends_path }
        format.turbo_stream {  flash[:notice] = "Friend request #{params[:status].to_i==1? " accepted" : "rejected " }" }
      end
    end
  end

  def pending_requests
    @pendingfriends=User.where(id: current_user.pending_friends_ids)
  end

  def search
    @input=params[:search]
    @users=User.where(id: current_user.accepted_friends_ids)
    @users=@users.where("users.username LIKE ?", [ "%#{@input}%" ]).or(@users.where("email LIKE ? ", "%#{@input}%"))
    render "index"
  end

  def search2
    @input=params[:search]
    @user=User.where.not(id: current_user.id).where.not(id: current_user.friendships.where(status: "accepted").pluck(:reciver_id))
    @user=@user.where("username LIKE ? ", "%#{@input}%").or(@user.where("email LIKE ? ", "%#{@input}%"))
    render "new"
  end
end
