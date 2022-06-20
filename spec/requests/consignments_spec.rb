require 'rails_helper'

RSpec.describe 'consignment', type: :request do
  let(:user){create(:sysAdmin)}

  before do
    post '/users/sign_in',params:{user:{email:user.email,password:user.password}}
    @token = {'Authorization':response.headers['Authorization']}
  end

  describe 'GET methods' do
    it 'get consignment' do
      create_list(:consignment,5,user_id: user.id)
      get '/warehouse-consignments?status=Checked&page=0&per_page=5',headers: @token
      expect(JSON.parse(response.body)['consignments'].count).to eq(5)
    end
    it 'search' do
      user = create(:inspector)
      consignment = create(:consignment,checked_user_id: user.id)
      get "/warehouse-consignments?status=Checked&search=#{consignment.consignment_seria} #{consignment.consignment_number}",params:{},headers:@token
      print(response.body)
      expect(JSON.parse(response.body)['consignments'][0]['id']).to eq(consignment.id)
    end
  end
end
