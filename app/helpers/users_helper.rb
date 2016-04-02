module UsersHelper
  def owner?(object)
    object.user.id == current_user.id
  end
end
