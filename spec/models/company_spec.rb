require 'rails_helper'

RSpec.describe Company, type: :model do
  before do
    UserRole.create(name: "System admin")
    UserRole.create(name: "Company owner")
    UserRole.create(name: "Company admin")
    UserRole.create(name: "Warehouse admin")
    UserRole.create(name: "Dispatcher")
    UserRole.create(name: "Inspector")
    UserRole.create(name: "Warehouse Manager")
  end
  context 'validations' do
    let(:user) {   User.create(email: 'qwerty@gmail.com', password: '12345678',
                               user_role: UserRole.find_by_name('System admin'), first_name: 'qwerty',
                               last_name: 'qwerty', address: 'qwerty', birth_date: 'qwerty')}
    let (:company) { Company.create(name: 'qwerty', address: 'qwerty', phone: '+375447625715', email: 'qwerty@gmail.com')}

    it 'should create company with user' do
      company.users << user
      expect(company.save).to eq(true)
    end

    it 'should create company without user' do
      expect(company.save).to eq(true)
    end

    it 'should not create company without name' do
      company.name = nil
      expect(company.save).to eq(false)
    end
    it 'should not create company with existing name' do
      company.save
      company2 = Company.new(name: 'qwerty', address: 'qwerty', phone: '+375447625715', email: 'qwerty@gmail.com')
      expect(company2.save).to eq(false)
    end
    it 'should not create company without address' do
      company.address = nil
      expect(company.save).to eq(false)
    end
    it 'should not create company without phone' do
      company.phone = nil
      expect(company.save).to eq(false)
    end
    it 'should not create company without email' do
      company.email = nil
      expect(company.save).to eq(false)
    end

    it 'should not create company with invalid email' do
      company.email = 'qwerty'
      expect(company.save).to eq(false)
    end
    it 'should not create company with invalid phone' do
      company.phone = 'qwerty'
      expect(company.save).to eq(false)
    end
    it 'should not create company without address' do
      company.address = nil
      expect(company.save).to eq(false)
    end

  end
end
