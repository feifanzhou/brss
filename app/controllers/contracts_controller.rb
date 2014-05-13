class ContractsController < ApplicationController
  include ApplicationHelper
  skip_before_action :verify_authenticity_token

  def index
    provision = Provision.find_by_code(params[:auth_code]) # Will get the first result — this is intentional for security
    return head(:forbidden) if provision.blank? || provision.is_deleted
    rep_name = provision.rep_name
    render json: Contract.includes(:appointments, :items, :user).where('appointments.rep_name = ? AND appointments.date >= ? AND items.is_deleted = ?', rep_name, Date.today, false).to_json
    # render json: Contract.all.map { |c| c.as_json_with_appointments_for_rep(rep_name) }
  end

  def update
    authenticate_provision
    contract = Contract.find(params[:id])
    if contract.blank?
      render json: {
        success: 0,
        errors: ['No contract found']
      }
      return
    else
      errors = []
      dropoff = contract.dropoff_appointment
      dropoff_date = nil
      begin
        dropoff_date = Date.parse(contract_params[:dropoff_date])
      rescue
        errors << "Unable to parse dropoff date"
      end
      if !dropoff.blank?
        dropoff.date = dropoff_date
        dropoff.save
      else
        # Create new dropoff appointment
        dropoff = Appointment.create(
          contract_id: contract.id,
          date: dropoff_date,
          notes: 'Auto-created dropoff from selecting date in app',
          status: 'pending',
          request_date: Date.today,
          appointment_type: 'dropoff'
        )
      end
      render json: {
        success: 1,
        errors: errors
      }
    end
  end

  def pallet
    contract = Contract.find(params[:id])
    if contract.blank?
      render json: {
        success: false,
        errors: ['No contract found']
      }
      return
    else
      pallet = params[:contract][:pallet]
      contract.pallet = pallet
      contract.save
      render json: {
        success: true,
        errors: []
      }
      return
    end
  end

  private
  def contract_params
    params.require(:contract).permit(:dropoff_date, :half_terms)
  end
end
