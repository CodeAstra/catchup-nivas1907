class AccountController < ApplicationController
  before_action :authenticate_user!
  before_action :find_user, only: [ :show, :update ]

  def show
    @posts = @user.posts.order(created_at: :desc)
    @friends_count = @user.accepted_friends_ids.count
  end

  def edit;end

  def update
    @valid = current_user.update(account_params)
    respond_to do |format|
      format.html { redirect_to valid ?  account_path(params[:id]): edit_account_path }
      format.turbo_stream { flash[:notice] = @valid ? "Account details are successfully updated.": "You are not authorized to update" }
    end
  end

  def privacy
    @valid = current_user.privacy_update(params[:user][:privacy_status].to_i)
    respond_to do |format|
      format.html { redirect_to account_path(params[:id])  }
      format.turbo_stream { flash[:notice] = @valid ? "Privacy option is successfully updated.": "You are not authorized to update"  }
    end
  end

  def cancel
    respond_to do |format|
      format.html { redirect_to account_path(current_user.id) }
      format.turbo_stream
    end
  end

private

  def account_params
    params.require(:user).permit(:username, :bio, :avatar, :status, :privacy_status)
  end

  def find_user
    @user=User.find(params[:id])
  end
end
