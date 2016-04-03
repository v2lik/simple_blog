module SessionsHelper
  def current_user
    @current_user ||= User.find_by(
      auth_token: User.encrypt(cookies[:auth_token])
    )
  end

  def signed_in?
    !current_user.nil?
  end

  def current_user?(user)
    user == current_user
  end

  def current_user=(user)
    @current_user = user
  end

  def login(user)
    auth_token = User.new_auth_token
    cookies.permanent[:auth_token] = auth_token
    user.update_column :auth_token, User.encrypt(auth_token)
    self.current_user = user
  end

  def logout
    current_user.update_column(
      :auth_token, User.encrypt(User.new_auth_token)
    )
    cookies.delete(:auth_token)
    self.current_user = nil
  end
end
