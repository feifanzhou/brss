module ApplicationHelper
  def save_login(user)
    return false if user.blank?
    cookies.permanent.signed[:user_remember] = user.remember_token
    return true
  end

  def current_user
    User.find_by_remember_token(cookies.signed[:user_remember])
  end

  def authenticate_provision
    auth_code = params[:auth_code]
    prov = Provision.find_by_code(auth_code)
    return head(:forbidden) if prov.blank? || prov.is_deleted
  end
end
