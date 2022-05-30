require 'rails_helper'

RSpec.describe 'users', type: :request do

  before do
    sign_in  create(:user)
  end

  describe 'GET methods' do
    it 'get users' do
      create_list(:user,5)
      get '/users/0/5'
      print(JSON.parse(response.body))
      expect(JSON.parse(response.body)['users']).to eq(5)
    end
  end
end
