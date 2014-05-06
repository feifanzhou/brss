# == Schema Information
#
# Table name: provisions
#
#  id          :integer          not null, primary key
#  code        :string(255)
#  description :string(255)
#  user_id     :integer
#  is_deleted  :boolean
#  created_at  :datetime
#  updated_at  :datetime
#  rep_name    :string(255)
#

class Provision < ActiveRecord::Base
  belongs_to :user  # Creator

  def creator
    self.user
  end

  def as_json(options = {})
    super.merge({ creator: self.creator.display_name })
  end
end
