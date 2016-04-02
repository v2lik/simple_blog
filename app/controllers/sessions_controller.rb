class SessionsController < ApplicationController
  before_action :set_user, only: :create
  before_action :skip_current_user, only: [:new, :create]

  def create
    if @user && @user.authenticate(session_params[:password])
      login @user
      redirect_to root_path
    else
      flash.now[:error] = I18n.t 'controllers.login_errors'
      render :new
    end
  end

  def destroy
    logout
    render :new
  end

  private

  def session_params
    params.require(:session).permit :login, :password
  end

  def set_user
    @user = User.find_by login: session_params[:login]
  end
end
