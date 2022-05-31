require 'rails_helper'

RSpec.describe 'consignment', type: :request do
  let(:user){create(:user,user_role_id: 2)}
  before do
    sign_in  user
  end

  describe 'GET methods' do
    it 'get consignment' do
      create_list(:company,5)
      header={'Authorization': ENV["sys_admin_token"]}
      create_list(:consignment,5,user_id: user.id)
      get '/warehouse-consignments?status=Checked&page=0&per_page=5',headers:header
      expect(JSON.parse(response.body)['consignments'].count).to eq(5)
    end
  end
end
