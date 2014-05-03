# == Schema Information
#
# Table name: analytics
#
#  id             :integer          not null, primary key
#  provision      :string(255)
#  appointment_id :integer
#  value          :string(255)
#  created_at     :datetime
#  updated_at     :datetime
#

class Analytic < ActiveRecord::Base
end
