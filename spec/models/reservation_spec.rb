# == Schema Information
#
# Table name: reservations
#
#  id         :bigint           not null, primary key
#  end_at     :datetime         not null
#  num_guests :integer          default(1)
#  start_at   :datetime         not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  guest_id   :bigint
#  shift_id   :bigint
#  table_id   :bigint
#
# Indexes
#
#  index_reservations_on_guest_id  (guest_id)
#  index_reservations_on_shift_id  (shift_id)
#  index_reservations_on_table_id  (table_id)
#
# Foreign Keys
#
#  fk_rails_...  (guest_id => guests.id)
#  fk_rails_...  (shift_id => shifts.id)
#  fk_rails_...  (table_id => tables.id)
#

require 'rails_helper'

RSpec.describe Reservation, type: :model do
  context "associations" do
    it { should belong_to(:table) }
    it { should belong_to(:guest) }
    it { should belong_to(:shift) }
  end
  
  context "validations" do
    it { should validate_presence_of(:guest_id) }
    it { should validate_presence_of(:table_id) }
    it { should validate_presence_of(:shift_id) }
    it { should validate_presence_of(:start_at) }
    it { should validate_presence_of(:end_at) }
    it { should validate_presence_of(:num_guests) }
  end
  
  let(:guest) { Guest.create name: 'Bruno', email: 'bruno@diniz.com' }
  let(:restaurant) { Restaurant.create name: 'restaurant', email: 'bruno@diniz.com', phone_number: '+353 89 976 3250', country_code: 'ie' }
  let(:shift) { Shift.create name: 'morning', restaurant: restaurant, start_at: '09:30', end_at: '13:30' }
  let(:table) { Table.create name: 'table 1', restaurant: restaurant, minimun_guest: 1, maximun_guest: 10 }
  
  let(:reservation_params) do
    {
      shift: shift,
      table: table,
      guest: guest,
      start_at: '2019-12-01 09:30',
      end_at: '2019-12-01 13:30',
      num_guests: 2
    }
  end
  
  let(:reservation) do
    described_class.new reservation_params 
  end
  
  describe '.check_num_guests' do
    let(:entity) do
      described_class.new table: table, num_guests: 11
    end
    
    before do
      entity.check_num_guests
    end
    
    subject { entity.errors.count.positive? }
    
    it { is_expected.to be_truthy }
  end
  
  describe '.validate_start_and_end_at' do
    let(:entity) do
      described_class.new start_at: '12:00', end_at: '09:00'
    end
    
    before do
      entity.validate_start_and_end_at
    end
    
    subject { entity.errors.count.positive? }
    
    it { is_expected.to be_truthy }
  end
  
  describe '.check_table_reservation' do
    let(:entity) { described_class.new reservation_params }
    
    before do
      reservation.save
      
      entity.check_table_reservation
    end
    
    subject { entity.errors.count.positive? }
    
    it { is_expected.to be_truthy }
  end
  
  describe '.validate_shift_range' do
    context 'check start at' do
      before do
        reservation.start_at = '2019-12-01 09:00'
        
        reservation.validate_shift_range        
      end
    
      subject { reservation.errors.count.positive? }
    
      it { is_expected.to be_truthy }
    end
    
    context 'check end at' do
      before do
        reservation.end_at = '2019-12-01 14:00'
        
        reservation.validate_shift_range
      end
    
      subject { reservation.errors.count.positive? }
    
      it { is_expected.to be_truthy }
    end
  end
end
