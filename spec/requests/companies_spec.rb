require 'rails_helper'

RSpec.describe 'companies', type: :request do
  let(:user){create(:user)}

  before do
    post '/login',params:{user:{email:user.email,password:user.password}}
    @token = {"Authorization": response.headers['Authorization']}
  end

  describe 'GET methods' do
    it 'get companies' do
      create_list(:company,5)
      get '/companies',params:{},headers:@token
      expect(response.status).to eq(401)
    end
  end
end
