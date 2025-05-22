class UserMailer < ApplicationMailer
  def daily_digest
    @user = params[:user]
    @users_count = params[:users_count]
    @posts_count = params[:posts_count]
    mail(to: @user.email, subject: "Your's Daily Digest Report is here")
  end
end
