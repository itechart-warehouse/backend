require 'rails_helper'

RSpec.describe 'consignment', type: :request do
  let(:user){create(:user)}

  before do
    post '/login',params:{user:{email:user.email,password:user.password}}
    @token = {'Authorization':response.headers['Authorization']}
  end

  describe 'GET methods' do
    it 'get consignment' do
      create_list(:consignment,5,user_id: user.id)
      get '/warehouse-consignments?status=Checked&page=0&per_page=5',headers: @token
      expect(JSON.parse(response.body)['consignments'].count).to eq(5)
    end
  end
end
