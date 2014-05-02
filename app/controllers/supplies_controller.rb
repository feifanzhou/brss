class SuppliesController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_filter :authenticate_provision
  
  def create
    prms = supply_params
    supply = Supply.find_by_supply_id_and_appointment_id(prms[:supply_id], prms[:appointment_id])
    if !supply.blank?
      supply.count = prms[:count].to_i
      supply.save
    else
      supply = Supply.create(
        appointment_id: prms[:appointment_id],
        description: prms[:description],
        count: prms[:count].to_i,
        supply_id: prms[:supply_id].to_i
      )
    end
    render json: {
      success: 1,
      errors: []
    }
  end

  private
  def supply_params
    params.require(:supply).permit(:appointment_id, :description, :count, :supply_id)
  end
end
