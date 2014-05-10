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
#  referral_source     :string(255)
#  tip                 :integer
#  percent_discount    :integer
#  fuel_surcharge      :integer
#  packaging_hours     :integer
#  rep_name            :string(255)
#  is_dollar_discount  :boolean
#  viewing_code        :string(255)
#  app_items_total     :decimal(, )
#  app_supplies_total  :decimal(, )
#  app_insurance_total :decimal(, )
#  app_packing_total   :decimal(, )
#  app_subtotal        :decimal(, )
#  app_total_tax       :decimal(, )
#  app_total_order     :decimal(, )
#  app_total_final     :decimal(, )
#  team                :string(255)
#

class Appointment < ActiveRecord::Base
  validates :appointment_type, presence: true  # App requires appointment_type to not crash

  belongs_to :contract
  has_many :supplies

  def as_json(options = {})
    super(except: [:created_at, :updated_at]).merge({ supplies: self.supplies })
  end

  def supplies_description
    desc = []
    self.supplies.each do |s|
      desc << "#{ s.name }: #{ s.count }"
    end
    desc.count == 0 ? 'No supplies' : desc.join(' | ')
  end
end
