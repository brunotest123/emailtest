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

require 'rails_helper'

RSpec.describe Restaurant, type: :model do
  before do
    described_class.create name: "bruno", country_code: 'ie', phone_number: "+353 89 976 3250", email: "bruno@diniz.com"
  end

  context "associations" do
    it { should have_many(:tables) }
    it { should have_many(:shifts) }
  end
  
  context "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:country_code) }
    it { should validate_presence_of(:phone_number) }
    it { should validate_presence_of(:email) }
    
    it { should validate_uniqueness_of(:email) }
  end
end
