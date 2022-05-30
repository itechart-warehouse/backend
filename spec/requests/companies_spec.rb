require 'rails_helper'

RSpec.describe 'companies', type: :request do
  let(:user){create(:user)}
  before do
    sign_in  user
  end

  describe 'GET methods' do
    it 'get companies' do
      create_list(:company,5)
      header={'Authorization': ENV["sys_admin_token"]}
      get '/company',params:{},headers:header
      print(user.user_role.name)
      print(response.body)
      expect(JSON.parse(response.body)['companies'].count).to eq(5)
    end
  end
end
