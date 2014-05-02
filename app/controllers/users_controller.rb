class UsersController < ApplicationController
  include ApplicationHelper

  def create
    u = User.new(user_params)
    u.is_admin = params[:user][:is_admin].blank? ? false : params[:user][:is_admin] == 'true'
    u.save
    success = !u.blank?
    save_login(u)
    errors = u.errors.full_messages
    success = false if !errors.blank?
    if !params[:user][:redirect_back].blank? 
      redirect_to params[:user][:redirect_back]
    else
      respond_to do |format|
        format.html { redirect_to admin_path }
        format.json { render json: { success: true, errors: [] } }
      end
    end
  end
  def login
    u = User.find_by_email(params[:user][:email].downcase)
    success = true
    if !u.blank? && u.authenticate(params[:user][:password])
      save_login(u)
    else
      success = false
    end
    respond_to do |format|
      format.html { redirect_to admin_provision_path }
      format.json { render json: { success: success, errors: success ? [] : ['Could not login with email and password'] } }
    end
  end

  def show
    @user = current_user
    respond_to do |format|
      format.html
      format.json { render json: current_user }
    end
  end

  private
  def user_params
    params.require(:user).permit(:fname, :lname, :email, :password)
  end
end
