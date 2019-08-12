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

require 'rails_helper'

RSpec.describe Table, type: :model do
  context "associations" do
    it { should belong_to(:restaurant) }
    it { should have_many(:reservations) }
  end
  
  context "validations" do
    it { should validate_presence_of(:restaurant_id) }
    it { should validate_presence_of(:name) }
  end
end
