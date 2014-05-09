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
      return
    else
      appt_prms = appointment_params
      appt.update!(appt_prms)
      if !appt_prms[:half_terms].blank?
        ctrt = appt.contract
        ctrt.half_terms = appt_prms[:half_terms].to_i
        ctrt.save
      end
      render json: {
        success: 1,
        errors: []
      }
    end
  end

  def create_charge
    authenticate_provision
    Analytic.create(provision: params[:auth_code], appointment_id: params[:appointmentID], value: "Creating charge for #{ params[:chargeAmount] }")
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
      errors << e.to_s
      success = false
      Analytic.create(provision: params[:auth_code], appointment_id: params[:appointmentID], value: 'Charge failed')
    end
    appt = Appointment.find(params[:appointmentID].to_i)
    if success
      appt.status = "paid"
      appt.save
      Analytic.create(provision: params[:auth_code], appointment_id: params[:appointmentID], value: 'Charge succeeded')
    else
      appt.status = 'error'
      appt.save
      Analytic.create(provision: params[:auth_code], appointment_id: params[:appointmentID], value: 'Charge failed')
    end
    render json: {
      success: (success ? 1 : 0),
      errors: errors
    }
  end

  private
  def appointment_params
    params.require(:appointment).permit(:insurance_cost, :notes, :on_campus, :coupon_code, :referral_source, :tip, :percent_discount, :fuel_surcharge, :packaging_hours, :half_terms)
  end
end
