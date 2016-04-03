class CommentsController < ApplicationController
  before_action :require_user
  before_action :set_comment, only: [:create, :edit, :update, :destroy]
  before_action :set_post, only: [:create, :edit, :update, :destroy]
  before_action :require_owner, only: [:edit, :update, :destroy]

  def create
    comment = current_user.comments.build comment_params
    comment.post = @post unless @comment
    comment.parent = @comment
    comment.save
    redirect_to @post
  end

  def update
    if @comment.update_attributes comment_params
      flash[:success] = I18n.t 'controllers.update', model: @comment.class
      redirect_to @post
    else
      render :edit
    end
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

  def require_owner
    redirect_to @post unless owner?(@comment)
  end

  def set_post
    @post = Post.find params[:post_id]
  end
end
