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
  has_many :items
end
