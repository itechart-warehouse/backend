FactoryBot.define do
  factory :user do
    first_name { 'test' }
    last_name { 'test' }
    active { true }
    birth_date { '10.10.2021' }
    sequence(:email) { |i| "test#{i}@test.com" }
    password{ 'password1' }
    user_role_id {1}
    association(:company)
  end
end
