class PostsController < ApplicationController
  before_action :redirect_unless_logged_in, except: :show
  before_action :redirect_unless_author, only: [:edit, :update]
  def new
    @post = Post.new
    render :new
  end

  def edit
    @post = Post.find(params[:id])
    render :edit
  end

  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :new
    end

  end

  def update
    @post = Post.find(params[:id])

    if @post.update(post_params)
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :edit
    end

  end

  def show
    @post = Post.find(params[:id])
    render :show
  end

  def post_params
    params.require(:post).permit(:title, :url, :content, :sub_ids => [])
  end

  def redirect_unless_author
    redirect_to subs_url unless current_user == Post.find(params[:id]).author
  end


end
