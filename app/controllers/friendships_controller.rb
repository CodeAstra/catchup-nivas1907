class FriendshipsController < ApplicationController
  before_action :authenticate_user!
  before_action :add_friends_list, only: [ :new, :search2 ]
  before_action :friends_list, only: [ :index, :search ]

  def index
    @pending_list_count = current_user.pending_friends_ids.count
  end

  def new; end

  def create
    @friendship=current_user.sent.create(reciver_id: params[:fid], friendship_status: Friendship.friendship_statuses[:pending])

    respond_to do |format|
      format.html { redirect_to new_friend_path }
      format.turbo_stream { flash[:notice] = "Friend request sent." }
    end
  end

  def update
    @valid_user = current_user.sent.find_by(id: params[:id])&.update_status(params[:status].to_i) || current_user.received.find_by(id: params[:id])&.update_status(params[:status].to_i)

    respond_to do |format|
      format.html { redirect_to friends_path }
      format.turbo_stream
    end
  end

  def pending_requests
    @pendingfriends = User.where(id: current_user.pending_friends_ids)
  end

  def search
    @input = params[:search]
    @friends_list = @friends_list.where("users.username LIKE ? OR email LIKE ?",  "%#{@input}%", "%#{@input}%")
    render "index"
  end

  def search2
    @input = params[:search]
    @add_friends_list =  @add_friends_list.where("users.username LIKE ? OR email LIKE ?",  "%#{@input}%", "%#{@input}%")
    render "new"
  end

private

  def add_friends_list
    @add_friends_list = User.where.not(id: current_user.accepted_friends_ids << current_user.id)
  end

  def friends_list
    @friends_list = User.where(id: current_user.accepted_friends_ids)
  end
end
