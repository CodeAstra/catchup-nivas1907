class FriendrequestsController < ApplicationController
  def index
    @pending_list=Friend.where(friend_id: current_user, status: "pending")
    @pending_list_count=@pending_list.count
  end

  def update
    if Friend.find(params[:id]).update(status: "accepted")
      redirect_to friend_index_path
    end
  end
  def destroy
    if Friend.destroy(params[:id])
      redirect_to friend_index_path
    end
  end
end
