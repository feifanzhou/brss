class ProvisionsController < ApplicationController
  include ApplicationHelper
  skip_before_action :verify_authenticity_token

  def index
    respond_to do |format|
      format.json { render json: Provision.where(is_deleted: false) }
    end
  end

  def create
    success = false
    if can_edit?
      success = true
      p = Provision.new(provision_params)
      p.user_id = current_user.id
      p.save
    end
    respond_to do |format|
      format.json { render json: { success: success, errors: [] } }
    end
  end

  def destroy
    success = false
    if can_edit?
      success = true
      p = Provision.find(params[:id])
      p.is_deleted = true
      p.save
    end
    respond_to do |format|
      format.json { render json: { success: success, errors: [] } }
    end
  end

  private
  def can_edit?
    current_user.is_admin
  end

  def provision_params
    params.require(:provision).permit(:code, :description, :is_deleted)
  end
end
