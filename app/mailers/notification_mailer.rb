class NotificationMailer < ActionMailer::Base
  default from: "\"Big Red Shipping and Storage\" <lmoran@studentagencies.com>"

  def appointment_notification(appt)
    @appointment = appt
    @user = appt.contract.user
    mail(to: 'feifan@me.com', subject: 'You have an appointment scheduled for tomorrow')
  end
end
