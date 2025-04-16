class FriendrequestsController < ApplicationController
  def index
    @pendingfriends_ids=current_user.pending_friends
    @pendingfriends=User.where(id: @pendingfriends_ids)
  end

  def update
    if Friendship.find(params[:id]).update_status(params[:status].to_i)
      respond_to do |format|
        format.html { redirect_to friends_path }
        format.turbo_stream {  flash[:notice] = "Friend request #{params[:status].to_i==1? " accepted" : "rejected " }" }
      end
    end
  end
end
