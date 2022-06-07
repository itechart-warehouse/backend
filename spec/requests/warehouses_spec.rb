require 'rails_helper'

RSpec.describe 'warehouses', type: :request do
  let(:user) {create(:user)}
  let(:company){create(:company)}
  before do
    post '/login',params:{user:{email:user.email,password:user.password}}
    @token = {'Authorization':response.headers['Authorization']}
  end

  describe 'GET methods' do
    it 'get warehouses' do
      create_list(:warehouse,5,company_id: company.id)
      get "/companies/#{company.id}/warehouses",headers:@token
      expect(JSON.parse(JSON.parse(response.body)['warehouses']).count).to eq(5)
    end
  end
end
