class CommentsController < ApplicationController
  def new
    @comment = Post.find(params[:post_id]).comments.new
    render :new
  end

  def new_nested
    @comment = Comment.find(params[:id]).child_comments.new
    render :new_nested
  end

  def show
    @comment = Comment.find(params[:id])
    render :show
  end

  def create
    @comment = current_user.comments.new(comment_params)
    if @comment.save
      redirect_to post_url(@comment.post)
    else
      flash.now[:errors] = @comment.errors.full_messages
      render :new
    end
  end

  def comment_params
    params.require(:comment).permit(:post_id, :content, :parent_comment_id)
  end

  def upvote
    comment = Comment.find(params[:id])
    comment.votes.create!(value: 1)
    redirect_to post_url(comment.post)
  end

  def downvote
    comment = Comment.find(params[:id])
    comment.votes.create!(value: -1)
    redirect_to post_url(comment.post)
  end

end
