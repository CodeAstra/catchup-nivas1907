class FriendrequestsController < ApplicationController
  def index
    @pending_list=Friend.where(friend_id: current_user, status: "pending")
    @pending_list_count=@pending_list.count
  end

  def update
    if Friend.find(params[:id]).update(status: "accepted")
      respond_to do |format|
        format.html { redirect_to friends_path }
        format.turbo_stream
      end
    end
  end
  def destroy
    @user=User.find(params[:user_id])
    if Friend.destroy(params[:id])
      respond_to do |format|
        format.html { redirect_to friends_path }
        format.turbo_stream
      end
    end
  end
end
