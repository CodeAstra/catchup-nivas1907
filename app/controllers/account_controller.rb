class AccountController < ApplicationController
  before_action :authenticate_user!
  before_action :find_user, only: [ :show, :update ]

  def show
    @posts=@user.posts.order(created_at: :desc)
    @friends_count=@user.accepted_friends_ids.size
  end

  def edit;end

  def update
    if @user.update(permit)
      respond_to do |format|
        format.html { redirect_to account_path(params[:id]) }
        format.turbo_stream { flash[:notice] = "Account details are successfully updated." }
      end
    end
  end

  def privacy
    if current_user.privacy_update(params[:user][:privacy_status].to_i)
      respond_to do |format|
        format.html { redirect_to account_path(params[:id])  }
        format.turbo_stream { flash[:notice] = "Privacy option is successfully updated." }
      end
    end
  end

  def cancel
    respond_to do |format|
      format.html { redirect_to account_path(current_user.id) }
      format.turbo_stream
    end
  end

private

  def permit
    params.require(:user).permit(:username, :bio, :avatar, :status, :privacy_status)
  end

  def find_user
    @user=User.find(params[:id])
  end
end
