# == Schema Information
#
# Table name: contracts
#
#  id            :integer          not null, primary key
#  user_id       :integer
#  contract_id   :string(255)
#  contract_type :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#  notes         :text
#  is_cancelled  :boolean
#  half_terms    :integer
#  pallet        :string(255)
#

class Contract < ActiveRecord::Base
  belongs_to :user

  has_many :appointments
  has_many :items

  def dropoff_appointment
    Appointment.find_by_contract_id_and_appointment_type(self.id, 'dropoff')
  end
  def dropoff_date
    appt = dropoff_appointment
    appt.blank? ? nil : appt.date
  end

  def active_items
    Item.where( contract_id: self.id, is_deleted: false ).order(:created_at)
  end

  def as_json_with_appointments_for_rep(rep_name)
    appts = Appointment.where("contract_id=#{ self.id } AND rep_name='#{ rep_name }'")
    self.as_json.merge({ appointments: appts })
  end

  def as_json(options = {})
    super(except: [:created_at, :updated_at, :user_id]).merge({ dropoff_date: self.dropoff_date, items: self.active_items, user: self.user })
  end
end
