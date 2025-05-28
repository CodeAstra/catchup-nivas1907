class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_post, only: [ :edit, :update, :destroy ]

  def index
      @posts = case params[:filter]
      when "friends"
      current_user.my_feed
      when "friends_of_friends"
      Post.where(user_id: current_user.one_layer_friends_ids).includes(:user).order(created_at: :desc)
      else
      current_user.my_feed
      end
      @pagy, @posts = pagy(@posts, items: 10)
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.create(post_params)

    if @post.save
      render partial: "post", locals: { post: @post }
    else
      render partial: "form", status: :unprocessable_entity, locals: { post: @post, form_path: posts_path, form_method: :post }
    end
  end

  def edit; end

 def update
   if @post.update(post_params)
     render partial: "post", locals: { post: @post }
   else
     render partial: "form", status: :unprocessable_entity, locals: { post: @post, form_path: post_path(@post), form_method: :patch }
   end
 end


  def destroy
    @destroy_success = @post.destroy
  end

  def cancel
    respond_to do |format|
      format.html { redirect_to posts_path }
      format.turbo_stream
    end
  end

  def onelayer
    @posts = Post.where(user_id:  current_user.one_layer_friends_ids).includes(:user).order(created_at: :desc)
  end

  def daily_digest
    posts = current_user.my_feed.where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day)
    users_count = posts.select(:user_id).distinct.count
    posts_count = posts.count
    UserMailer.with(user: current_user, users_count: users_count, posts_count: posts_count).daily_digest.deliver_later
  end

private

  def post_params
    params.require(:post).permit(:title, :description)
  end

  def find_post
    @post = current_user.posts.find(params[:id])
  end
end
