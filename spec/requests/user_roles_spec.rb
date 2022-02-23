require 'rails_helper'

RSpec.describe "UserRoles", type: :request do
  before do
    UserRole.create(name: "System admin")
    UserRole.create(name: "Company owner")
    UserRole.create(name: "Company admin")
    UserRole.create(name: "Warehouse admin")
    UserRole.create(name: "Dispatcher")
    UserRole.create(name: "Inspector")
    UserRole.create(name: "Warehouse Manager")
  end
  it 'should get all roles' do
    get '/roles'
    expect(response).to have_http_status(200)
  end
end
