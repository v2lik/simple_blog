class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = I18n.t 'controllers.create', model: @user.class
      redirect_to root_path
    else
      render :new
    end
  end

  def update
    if @user.update_attributes user_params
      flash[:success] = I18n.t 'controllers.update', model: @user.class
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    flash[:success] = I18n.t 'controllers.destroy', model: @user.class
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit :login, :password
  end

  def set_user
    @user = User.find params[:id]
  end
end
