# == Schema Information
#
# Table name: restaurants
#
#  id         :bigint           not null, primary key
#  email      :string           not null
#  name       :string           not null
#  phone      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_restaurants_on_email  (email) UNIQUE
#

class Restaurant < ApplicationRecord
  has_many :tables
  has_many :shifts
  
  validates :name, presence: true
  validates :email, presence: true
  validates :country_code, presence: true
  validates :phone_number, presence: true
  
  validates :email, uniqueness: true
  
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP, message: "only allows valid emails" }
  
  attr_accessor :country_code, :phone_number
  
  before_save :check_phone
  
  def check_phone
    if TelephoneNumber.valid?(phone_number, country_code, %i[mobile fixed_line])
      self.phone = TelephoneNumber.parse(phone_number, country_code).international_number
      return
    end
    errors.add :phone_number, 'invalid'
  end
end
