require 'rails_helper'

RSpec.describe 'companies', type: :request do
  let(:user){create(:sysAdmin)}

  before do
    post '/users/sign_in',params:{user:{email:user.email,password:user.password}}
    @token = {"Authorization": response.headers['Authorization']}
  end

  describe 'GET methods' do
    it 'get companies' do
      create_list(:company,5)
      get '/companies?page=0&per_page=5',params:{},headers:@token
      expect(JSON.parse(response.body)['companies'].count).to eq(5)
    end
    it 'search' do
      company = create(:company)
      get "/companies?search=#{company.name}",params:{},headers:@token
      expect(JSON.parse(response.body)['companies'][0]['id']).to eq(company.id)
    end
  end
end
