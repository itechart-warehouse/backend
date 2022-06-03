require 'rails_helper'

RSpec.describe 'warehouses', type: :request do
  let(:company){ create(:company) }
  let(:warehouse) { create(:warehouse,company_id: company.id)}
  let(:user) {create(:sysAdmin )}

  before do
    post '/users/sign_in',params:{user:{email:user.email,password:user.password}}
    @token = {'Authorization':response.headers['Authorization']}
  end

  describe 'GET methods' do
    it 'get warehouses' do
      create_list(:warehouse,5,company_id: company.id)
      get "/companies/#{company.id}/warehouses",headers:@token
      expect(JSON.parse(JSON.parse(response.body)['warehouses']).count).to eq(5)
    end
    it 'search' do
      create(:admin,warehouse_id:warehouse.id )
      get "/companies/#{company.id}/warehouses?search=#{warehouse.name}",headers:@token
      expect(JSON.parse(JSON.parse(response.body)['warehouses'])[0]["id"]).to eq(warehouse.id)
    end
  end
end
