# == Schema Information
#
# Table name: guests
#
#  id         :bigint           not null, primary key
#  email      :string           not null
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_guests_on_email  (email) UNIQUE
#

class Guest < ApplicationRecord
  has_many :reservations
  
  validates :name, presence: true
  validates :email, presence: true
  
  validates :email, uniqueness: true
  
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP, message: "only allows valid emails" }
end
