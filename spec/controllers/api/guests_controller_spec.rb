require 'rails_helper'

module Api
  RSpec.describe GuestsController, type: :controller do
    describe '.create' do
      context 'OK' do
        let(:guest_params) do
          {
            name: 'Bruno Diniz',
            email: 'bruno@dublin.co'
          }
        end
      
        before do
          post :create, params: { guest: guest_params, format: :json }
        end
      
        subject { response.code }
      
        it { is_expected.to eq('200') }
      end
      
      context 'Error' do
        let(:guest_params) do
          {
            name: 'Bruno Diniz',
            email: 'bruno'
          }
        end
      
        before do
          post :create, params: { guest: guest_params, format: :json }
        end
      
        subject { response.code }
      
        it { is_expected.to eq('422') }
      end
    end
  end
end