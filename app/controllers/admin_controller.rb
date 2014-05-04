class AdminController < ApplicationController
  include ApplicationHelper

  def show
    @should_show_create = User.find_by_is_admin(true).blank? ? true : false
  end

  def provision
    @curr_name = current_user.display_name
  end

  def do_refresh
    get_latest_from_gorges
    render json: { success: 1, errors: [] }
  end
end
