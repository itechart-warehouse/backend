require 'rails_helper'

RSpec.describe 'users', type: :request do
  let(:user){create(:user)}

  before do
    post '/login',params:{user:{email:user.email,password:user.password}}
    @token = {'Authorization':response.headers['Authorization']}
  end

  describe 'GET methods' do
    it 'get users' do
      create_list(:user,5)
      get '/users?page=0&per_page=5',headers:@token
      expect(JSON.parse(JSON.parse(response.body)['users']).count).to eq(5)
    end
  end
end
