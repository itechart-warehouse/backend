require 'rails_helper'

RSpec.describe 'users', type: :request do

  before do
    sign_in  create(:user)
  end

  describe 'GET methods' do
    it 'get users' do
      create_list(:user,5)
      header={'Authorization': ENV["sys_admin_token"]}
      get '/users/0/5',headers:header
      expect(JSON.parse(JSON.parse(response.body)['users']).count).to eq(5)
    end
  end
end
