module ApplicationHelper
  def save_login(user)
    return false if user.blank?
    cookies.permanent.signed[:user_remember] = user.remember_token
    return true
  end
end
