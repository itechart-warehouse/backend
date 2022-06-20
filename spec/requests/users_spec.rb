require 'rails_helper'

RSpec.describe 'users', type: :request do
  let(:user){create(:sysAdmin)}

  before do
    post '/users/sign_in',params:{user:{email:user.email,password:user.password}}
    @token = {'Authorization':response.headers['Authorization']}
  end

  describe 'GET methods' do
    it 'get users' do
      create_list(:inspector,5)
      get '/users?page=0&per_page=5',headers:@token
      expect(JSON.parse(JSON.parse(response.body)['users']).count).to eq(5)
    end
    it 'search' do
      get "/users?search=#{user.first_name} #{user.last_name}",headers:@token
      expect(JSON.parse(JSON.parse(response.body)['users'])[0]["id"]).to eq(user.id)
    end
  end
end
