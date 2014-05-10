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

  def name
    case self.supply_id
      when 1 return 'Tape dispenser'
      when 2 return 'Bubble wrap'
      when 7 return 'Packing tape'
      when 26 return 'Small box'
      when 27 return 'Large box'
      when 35 return 'TV box'
      else return 'Unknown'
    end
  end
end
