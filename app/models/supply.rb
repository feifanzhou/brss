# == Schema Information
#
# Table name: supplies
#
#  id             :integer          not null, primary key
#  appointment_id :integer
#  description    :string(255)
#  count          :integer
#  created_at     :datetime
#  updated_at     :datetime
#  supply_id      :integer
#

class Supply < ActiveRecord::Base
  belongs_to :appointment
end
