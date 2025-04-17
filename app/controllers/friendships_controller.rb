class FriendshipsController < ApplicationController
  before_action :authenticate_user!
  before_action :not_friends_list, only: [ :new, :search2 ]
  before_action :friends_list, only: [ :index, :search ]

  def index
    @pending_list_count = current_user.pending_friends_ids.count
  end

  def new; end

  def create
      Friendship.create(reciver_id: params[:fid], sender_id: current_user.id, friendship_status: Friendship.friendship_statuses[:pending])
      respond_to do |format|
        format.html { redirect_to new_friend_path }
        format.turbo_stream { flash[:notice] = "Friend request sent." }
      end
  end

  def update
    @friend=Friendship.find(params[:id])
    valid= (current_user==@friend.sender || current_user==@friend.reciver)
    @friend.update_status(params[:status].to_i)
    respond_to do |format|
      format.html { redirect_to friends_path }
      format.turbo_stream {  flash[:notice] = valid ? "Friend request #{params[:status].to_i==1? " accepted" : "rejected " }": "In valid Request" }
    end
  end

  def pending_requests
    @pendingfriends = User.where(id: current_user.pending_friends_ids)
  end

  def search
    @input = params[:search]
    @friends_list = @friends_list.where("users.username LIKE ?", [ "%#{@input}%" ]).or(@friends_list.where("email LIKE ? ", "%#{@input}%"))
    render "index"
  end

  def search2
    @input = params[:search]
    @not_friends_list = @not_friends_list.where("username LIKE ? ", "%#{@input}%").or(@not_friends_list.where("email LIKE ? ", "%#{@input}%"))
    render "new"
  end

private

  def not_friends_list
    @not_friends_list = User.where.not(id: current_user.id).where.not(id: current_user.accepted_friends_ids)
  end

  def friends_list
    @friends_list = User.where(id: current_user.accepted_friends_ids)
  end
end
