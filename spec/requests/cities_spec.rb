require 'rails_helper'

RSpec.describe 'city', type: :request do
  let(:user){create(:user, :sysAdmin)}
  let(:country) {create(:country)}

  before do
    post '/users/sign_in',params:{user:{email:user.email,password:user.password}}
    @token = {'Authorization':response.headers['Authorization']}
  end

  describe 'city CRUD methods' do
    it 'get all' do
      create_list(:city,5, country: country)
      get "/settings/countries/#{country.id}/cities?&page=0&per_page=5",headers: @token
      expect(City.count).to eq(5)
      #expect(response).to have_http_status(200)
    end

    it 'create' do
      total_count = City.count
      post "/settings/countries/#{country.id}/cities", params:{city: {name: 'City Test1', country_id: country.id}},headers: @token
      p response.body
      expect(total_count+1).to eq(City.count)
      # expect(response).to have_http_status(200)
    end
    it 'update' do
      city = create(:city)
      patch "/settings/countries/#{country.id}/cities/#{city.id}" , params:{city: {name: 'City Test1', country_id: country.id}}, headers: @token
      expect(City.find(city.id).name).to eq('City Test1')
      # expect(response).to have_http_status(200)
    end
    it 'delete' do
      city = create(:city)
      total_count = City.count
      delete "/settings/countries/#{country.id}/cities/#{city.id}",headers: @token
      expect(total_count-1).to eq(City.count)
      #expect(response).to have_http_status(200)
    end
  end
end
