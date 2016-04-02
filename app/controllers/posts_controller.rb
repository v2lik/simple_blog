class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    # current user
    @post = User.last.posts.build post_params
    if @post.save
      flash[:success] = I18n.t('controllers.posts.create')
      redirect_to @post
    else
      render :new
    end
  end

  def update
    if @post.update_attributes post_params
      flash[:success] = I18n.t('controllers.posts.update')
      redirect_to @post
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    respond_to do |format|
      format.html do
        flash[:success] = I18n.t('controllers.posts.destroy')
        redirect_to posts_path
      end
      format.js { render layout: false }
    end
  end

  private

  def post_params
    params.require(:post).permit :title, :body
  end

  def set_post
    @post = Post.find params[:id]
  end
end
