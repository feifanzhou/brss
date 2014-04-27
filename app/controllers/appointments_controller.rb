class AppointmentsController < ApplicationController
  skip_before_action :verify_authenticity_token
  def update
    puts appointment_params.to_s
    appt = Appointment.find(params[:id])
    if appt.blank?
      render json: {
        success: 0,
        errors: ['No appointment found']
      }
    else
      appt.update!(appointment_params)
      render json: {
        success: 1,
        errors: []
      }
    end
  end

  private
  def appointment_params
    params.require(:appointment).permit(:insurance_cost, :notes, :on_campus)
  end
end
