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

require 'rails_helper'

RSpec.describe Guest, type: :model do
  before do
    described_class.create name: "bruno", email: "bruno@diniz.com"
  end
  
  context 'association' do
    it { should have_many(:reservations) }
  end
  
  context "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
    
    it { should validate_uniqueness_of(:email) }
  end
end
