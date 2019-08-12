# == Schema Information
#
# Table name: tables
#
#  id            :bigint           not null, primary key
#  maximun_guest :integer          default(1)
#  minimun_guest :integer          default(1)
#  name          :string           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  restaurant_id :bigint
#
# Indexes
#
#  index_tables_on_restaurant_id  (restaurant_id)
#
# Foreign Keys
#
#  fk_rails_...  (restaurant_id => restaurants.id)
#

class Table < ApplicationRecord
  belongs_to :restaurant
  has_many :reservations
  
  validates :restaurant_id, presence: true
  validates :name, presence: true
end
