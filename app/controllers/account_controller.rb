class AccountController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.order(created_at: :desc)
    @friends_count = @user.accepted_friends_ids.count
  end

  def edit; end

  def update
    @update_success = current_user.update(account_params)

    respond_to do |format|
      if @update_success
        format.html { redirect_to account_path(current_user) }
        format.turbo_stream { flash[:notice] = "Account details are successfully updated." }
      else
        format.html { redirect_to edit_account_path }
        format.turbo_stream { flash[:notice] = "You are not authorized to update" }
      end
    end
  end

  def privacy
    @privacy_success = current_user.update(privacy_status: params[:user][:privacy_status].to_i)
  end

  def cancel
    respond_to do |format|
      format.html { redirect_to account_path(current_user.id) }
      format.turbo_stream
    end
  end

private

  def account_params
    params.require(:user).permit(:username, :bio, :avatar)
  end
end
