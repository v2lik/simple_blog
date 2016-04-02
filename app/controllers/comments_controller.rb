class CommentsController < ApplicationController
  before_action :set_comment, only: [:create, :edit, :update, :destroy]
  before_action :set_post, only: [:create, :edit, :update, :destroy]

  def create
    # current user
    comment = User.last.comments.build comment_params
    comment.post = @post unless @comment
    comment.parent = @comment
    comment.save
    redirect_to @post
  end

  def update
    @comment.update_attributes comment_params
    redirect_to @post
  end

  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to @post }
      format.js { render layout: false }
    end
  end

  private

  def comment_params
    params.require(:comment).permit :body
  end

  def set_comment
    @comment = Comment.find_by id: params[:id]
  end

  def set_post
    @post = Post.find params[:post_id]
  end
end