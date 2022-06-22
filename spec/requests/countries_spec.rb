require 'rails_helper'

RSpec.describe 'country', type: :request do
  let(:user){create(:user, :sysAdmin)}

  before do
    post '/users/sign_in',params:{user:{email:user.email,password:user.password}}
    @token = {'Authorization':response.headers['Authorization']}
  end

  describe 'country CRUD methods' do
    it 'get all' do
      create_list(:country,5)
      get '/settings/countries?&page=0&per_page=5',headers: @token
      expect(Country.count).to eq(5)
      #expect(response).to have_http_status(200)
    end

    it 'create' do
      total_count = Country.count
      post '/settings/countries', params:{country: {name: 'Country Test1'}},headers: @token
       expect(total_count+1).to eq(Country.count)
      # expect(response).to have_http_status(200)
    end
    it 'update' do
      country = create(:country)
      patch "/settings/countries/#{country.id}" , params:{country: {name: 'Country Test1'}}, headers: @token
      expect(Country.find(country.id).name).to eq('Country Test1')
      # expect(response).to have_http_status(200)
    end
    it 'delete' do
      country = create(:country)
      total_count = Country.count
      delete "/settings/countries/#{country.id}",headers: @token
      expect(total_count-1).to eq(Country.count)
      #expect(response).to have_http_status(200)
    end
  end
end
