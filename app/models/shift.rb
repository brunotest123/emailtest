# == Schema Information
#
# Table name: shifts
#
#  id            :bigint           not null, primary key
#  end_at        :time             not null
#  name          :string           not null
#  start_at      :time             not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  restaurant_id :bigint
#
# Indexes
#
#  index_shifts_on_restaurant_id  (restaurant_id)
#
# Foreign Keys
#
#  fk_rails_...  (restaurant_id => restaurants.id)
#

class Shift < ApplicationRecord
  belongs_to :restaurant
  has_many :reservations
  
  validates :name, presence: true
  validates :start_at, presence: true
  validates :end_at, presence: true
  
  before_save :validate_start_and_end_at
  
  def validate_start_and_end_at
    return if start_at < end_at
    errors.add :end_at, 'can not be in the past'
  end
end
