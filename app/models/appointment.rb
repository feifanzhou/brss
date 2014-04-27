# == Schema Information
#
# Table name: appointments
#
#  id                  :integer          not null, primary key
#  appointment_id      :string(255)
#  date                :date
#  insurance_cost      :integer
#  address             :string(255)
#  notes               :text
#  on_campus           :boolean
#  request_date        :date
#  coupon_code         :string(255)
#  price_match         :boolean
#  referrer            :string(255)
#  pre_arrival         :boolean
#  pre_arrival_address :string(255)
#  contract_id         :integer
#  at_counter          :boolean
#  term_ends           :date
#  term_count          :integer
#  created_at          :datetime
#  updated_at          :datetime
#  status              :string(255)
#  appointment_type    :string(255)
#  is_cancelled        :boolean
#  timeslot_number     :integer
#  timeslot_text       :string(255)
#

class Appointment < ActiveRecord::Base
  belongs_to :contract

  def as_json(options = {})
    super(except: [:created_at, :updated_at])
  end
end
