require 'rails_helper'

RSpec.describe 'warehouses', type: :request do
  let(:user) {create(:user)}
  let(:company){create(:company)}
  before do
    sign_in  user
  end

  describe 'GET methods' do
    it 'get warehouses' do
      create_list(:warehouse,5,company_id: company.id)
      header={'Authorization': ENV["sys_admin_token"]}
      get "/companies/#{company.id}/warehouses",headers:header
      expect(JSON.parse(JSON.parse(response.body)['warehouses']).count).to eq(5)
    end
  end
end
