require 'rails_helper'

RSpec.describe 'consignment', type: :request do
  let(:user) {create(:user)}
  before do
    sign_in  user
  end

  describe 'GET methods' do
    it 'get consignment' do
      create_list(:consignment,5,user_id: user.id)
      get '/warehouse-consignment/Checked/0/5'
      print(response.header)
      expect(response.body).to eq('0')
    end
  end
end
