require 'rails_helper'

RSpec.describe User, type: :model do
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
    let (:company) { Company.create(name: 'qwerty', address: 'qwerty', phone: 'qwerty', email: 'qwerty@gmail.com')}

    it 'should create user' do
      user.company = company
      expect(user.save).to eq(true)
    end
    it 'should not create user without company' do
      expect(user.save).to eq(false)
    end
    it 'should not create user with invalid email' do
      user.email = 'qwerty'
      user.company = company
      expect(user.save).to eq(false)
    end
    it 'should not create user with invalid password' do
      user.password = '123'
      user.company = company
      expect(user.save).to eq(false)
    end
    it 'should not create user without user_role' do
      user.user_role = nil
      user.company = company
      expect(user.save).to eq(false)
    end
    it 'should not create user without first_name' do
      user.first_name = nil
      user.company = company
      expect(user.save).to eq(false)
    end

    it 'should not create user without last_name' do
      user.last_name = nil
      user.company = company
      expect(user.save).to eq(false)
    end

    it 'should not create user without address' do
      user.address = nil
      user.company = company
      expect(user.save).to eq(false)
    end

    it 'should not create user without birth_date' do
      user.birth_date = nil
      user.company = company
      expect(user.save).to eq(false)
    end


  end

end

