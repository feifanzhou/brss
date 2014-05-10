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
    name = ''
    if self.supply_id == 1 then name = 'Tape dispenser'
    elsif self.supply_id == 2 then name = 'Bubble wrap'
    elsif self.supply_id == 7 then name = 'Packing tape'
    elsif self.supply_id == 26 then name = 'Small box'
    elsif self.supply_id == 27 then name = 'Large box'
    elsif self.supply_id == 35 then name = 'TV box'
    else name = 'Unknown'
    end
  end
end
