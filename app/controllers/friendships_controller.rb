class FriendshipsController < ApplicationController
  before_action :authenticate_user!
  before_action :add_friends_list, only: [ :new, :search ]
  before_action :friends_list, only: [ :index, :search ]

  def index; end

  def new; end

  def create
    @friendship = current_user.sent_friendships.create(reciver_id: params[:fid])
    receiver = User.find_by(id: params[:fid])

    if @friendship.persisted? && receiver.present?
      FriendRequestMailer.with(user: current_user, friend: receiver).new_request.deliver_now
    end
  end

  def update
    @friendship = current_user.sent_friendships.find_by(id: params[:id])  || current_user.received_friendships.find_by(id: params[:id])
    @update_success = @friendship&.update(friendship_status: params[:status].to_i)
     if @update_success && @friendship.accepted?
      sender = @friendship.sender
      receiver = @friendship.reciver
      FriendRequestMailer.with(user: sender, friend: receiver).request_accepted.deliver_now
     end
  end

  def pending_requests
    @pending_requests = User.where(id: current_user.pending_friends_ids).includes(:avatar_attachment)
  end

  def rejected_requests
    @rejected_requests = User.where(id: current_user.rejected_friends_ids).includes(:avatar_attachment)
  end

  def cancel_request
    @friendship = Friendship.find(params[:id])
    @friendship.destroy
  end

  def search
    @input = params[:search].strip
    if params[:type] == "friends"
      @friends_list = @friends_list.where("users.username LIKE ? OR users.email = ?", "%#{@input}%", @input)

      render "index"
    else
      @add_friends_list = @add_friends_list.where("users.username LIKE ? OR users.email = ?", "%#{@input}%", @input)

      render "new"
    end
  end


private

  def add_friends_list
    @add_friends_list = User.where.not(id: current_user.accepted_friends_ids << current_user.id).includes(:avatar_attachment)
  end

  def friends_list
    @friends_list = User.where(id: current_user.accepted_friends_ids).includes(:avatar_attachment)
  end
end
