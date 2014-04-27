# == Schema Information
#
# Table name: items
#
#  id          :integer          not null, primary key
#  contract_id :integer
#  item_type   :string(255)
#  description :string(255)
#  notes       :text
#  weight      :decimal(, )
#  pallet      :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#  box_id      :integer
#  is_deleted  :boolean
#

class Item < ActiveRecord::Base
  belongs_to :contract
end
