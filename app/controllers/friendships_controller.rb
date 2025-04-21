class FriendshipsController < ApplicationController
  before_action :authenticate_user!
  before_action :add_friends_list, only: [ :new, :search ]
  before_action :friends_list, only: [ :index, :search ]

  def index; end

  def new; end

  def create
    @friendship = current_user.sent.create(reciver_id: params[:fid])

    respond_to do |format|
      format.html { redirect_to new_friend_path }
      format.turbo_stream { flash[:notice] = "Friend request sent." }
    end
  end

  def update
    friendship = current_user.sent.find_by(id: params[:id])  || current_user.received.find_by(id: params[:id])
    @update_success = friendship&.update_status(params[:status].to_i)

    respond_to do |format|
      format.html { redirect_to friends_path }
      format.turbo_stream
    end
  end

  def pending_requests
    @pending_requests = User.where(id: current_user.pending_friends_ids)
  end

  def search
    if params[:type] == "friends"
      @input = params[:search].strip()
      @friends_list = @friends_list.where("users.username LIKE ? OR email LIKE ?", "%#{@input}%", "%#{@input}%")

      render "index"
    else
      @input = params[:search].strip()
      @add_friends_list =  @add_friends_list.where("users.username LIKE ? OR email LIKE ?", "%#{@input}%", "%#{@input}%")

      render "new"
    end
  end


private

  def add_friends_list
    @add_friends_list = User.where.not(id: current_user.accepted_friends_ids << current_user.id)
  end

  def friends_list
    @friends_list = User.where(id: current_user.accepted_friends_ids)
  end
end
