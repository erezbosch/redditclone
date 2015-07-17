class CommentsController < ApplicationController
  def new
    @comment = Post.find(params[:post_id]).comments.new
    render :new
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
    params.require(:comment).permit(:post_id, :content)
  end
end
