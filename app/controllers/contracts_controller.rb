class ContractsController < ApplicationController
  skip_before_action :verify_authenticity_token
  def index
    respond_to do |format|
      format.json { render json: Contract.all.to_json }
    end
  end

  def update
    contract = Contract.find(params[:id])
    if contract.blank?
      render json: {
        success: 0,
        errors: ['No contract found']
      }
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

  private
  def contract_params
    params.require(:contract).permit(:dropoff_date)
  end
end
