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
#

class Contract < ActiveRecord::Base
  belongs_to :user
  
  has_many :appointments
  has_many :items

  def as_json(options = {})
    super(except: [:created_at, :updated_at, :user_id]).merge({ appointments: self.appointments, items: self.items, user: self.user })
  end
end
