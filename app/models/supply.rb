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
    if self.supply_id == 1 return 'Tape dispenser'
    elsif self.supply_id == 2 return 'Bubble wrap'
    elsif self.supply_id == 7 return 'Packing tape'
    elsif self.supply_id == 26 return 'Small box'
    elsif self.supply_id == 27 return 'Large box'
    elsif self.supply_id == 35 return 'TV box'
    else return 'Unknown'
    end
  end
end
