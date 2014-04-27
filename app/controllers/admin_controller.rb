class AdminController < ApplicationController
  def show
    @should_show_create = User.find_by_is_admin(true).blank? ? true : false
  end
end
