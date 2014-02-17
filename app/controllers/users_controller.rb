class UsersController < ApplicationController
  include ApplicationHelper

  def create
    u = User.create(user_params)
    success = !u.blank?
    save_login(u)
    errors = u.errors.full_messages
    success = false if !errors.blank?
    render json: {
      success: success,
      errors: errors
    }
  end
  def login
    u = User.find_by_email(params[:user][:email].downcase)
    success = true
    if !u.blank? && u.authenticate(params[:user][:password])
      save_login(u)
    else
      success = false
    end
    render json: {
      success: success,
      errors: success ? [] : ['Could not login with email and password']
    }
  end

  def show
  end

  private
  def user_params
    params.require(:user).permit(:fname, :lname, :email, :password)
  end
end
