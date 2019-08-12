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

require 'rails_helper'

RSpec.describe Shift, type: :model do
  context "associations" do
    it { should belong_to(:restaurant) }
    it { should have_many(:reservations) }
  end
  
  context "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:start_at) }
    it { should validate_presence_of(:end_at) }
  end
  
  describe '.validate_start_and_end_at' do
    let(:shift_params) do
      {
        start_at: '12:00',
        end_at: '09:00'
      }
    end
    
    let(:shift) do
      described_class.new shift_params
    end
    
    before do
      shift.validate_start_and_end_at
    end
    
    subject { shift.errors.count.positive? }
    
    it { is_expected.to be_truthy }
  end
end
