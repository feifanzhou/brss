class AppointmentsController < ApplicationController
  include ApplicationHelper
  skip_before_action :verify_authenticity_token

  def update
    authenticate_provision
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

  def create_charge
    authenticate_provision
    token = params[:stripeToken]
    success = true
    errors = []
    begin
      charge = Stripe::Charge.create(
        amount: params[:chargeAmount].to_i,
        currency: 'usd',
        card: token,
        description: params[:chargeDescription]
      )
    rescue Stripe::CardError => e
      puts "STRIPE ERROR: #{ e.to_s }"
      errors << e
      success = false
    end
    if success
      appt = Appointment.find(params[:appointmentID].to_i)
      appt.status = "paid"
      appt.save
    end
    render json: {
      success: (success ? 1 : 0),
      errors: errors
    }
  end

  private
  def appointment_params
    params.require(:appointment).permit(:insurance_cost, :notes, :on_campus, :coupon_code, :referral_source, :tip, :percent_discount, :fuel_surcharge, :packaging_hours)
  end
end
