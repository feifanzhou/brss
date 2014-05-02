# == Schema Information
#
# Table name: users
#
#  id               :integer          not null, primary key
#  email            :string(255)
#  fname            :string(255)
#  lname            :string(255)
#  password_digest  :string(255)
#  address1         :string(255)
#  address2         :string(255)
#  city             :string(255)
#  state            :string(2)
#  remember_token   :string(255)
#  zip              :string(255)
#  phone            :string(255)
#  country          :string(255)
#  is_rep           :boolean
#  is_admin         :boolean
#  is_active        :boolean
#  created_at       :datetime
#  updated_at       :datetime
#  net_id           :string(255)
#  gender           :string(1)
#  school           :string(255)
#  major            :string(255)
#  grad_year        :string(4)
#  dob              :date
#  is_international :boolean
#  should_spam      :boolean
#

class User < ActiveRecord::Base
  validates :fname, presence: true
  validates :lname, presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }

  has_secure_password validations: false  # Don't require password confirmation
  before_save { create_remember_token if (self.remember_token.blank? && self.password_digest && defined?(self.password_digest)) }
  before_save { |user| user.email = email.downcase }

  has_many :contracts
  has_many :provisions  # Provisions created by this user

  def display_name
    return "#{ self.fname } #{ self.lname }"
  end

  def create_remember_token
    self.remember_token = SecureRandom.urlsafe_base64(32, false)
  end

  def as_json(options = {})
    super(except: [:password_digest]).merge({ display_name: self.display_name })
  end
end
