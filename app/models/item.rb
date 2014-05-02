# == Schema Information
#
# Table name: items
#
#  id            :integer          not null, primary key
#  contract_id   :integer
#  item_type     :string(255)
#  description   :string(255)
#  notes         :text
#  weight        :decimal(, )
#  pallet        :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#  box_id        :integer
#  is_deleted    :boolean
#  value         :integer
#  should_insure :boolean
#  custom_price  :integer
#

class Item < ActiveRecord::Base
  belongs_to :contract

  validates :weight, presence: true  # Box is defined by its weight

  def as_json(options = {})
    super(except: [:created_at, :updated_at])
  end
end
