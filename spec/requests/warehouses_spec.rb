require 'rails_helper'

RSpec.describe 'warehouses', type: :request do
  let(:user) {create(:user)}
  before do
    sign_in  user
  end

  describe 'GET methods' do
    it 'get warehouses' do
      create_list(:warehouse,5)
      print(user.sadmin?)
      get "/companies/#{Company.first.id}/warehouses"

      expect(response).to eq('1')
    end
  end
end
