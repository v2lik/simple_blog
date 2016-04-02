class ApplicationController < ActionController::Base
  include SessionsHelper
  include UsersHelper

  protect_from_forgery with: :exception
  rescue_from ActiveRecord::RecordNotFound, with: :render_404

  private

  def require_user
    redirect_to login_path unless current_user
  end

  def skip_current_user
    redirect_to root_path if current_user
  end

  def render_404
    render file: 'public/404.html', layout: false, status: 404
  end
end
