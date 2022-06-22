FactoryBot.define do
  factory :user do
    first_name { 'test' }
    last_name { 'test' }
    active { true }
    birth_date { '10.10.2021' }
    user_role_id {'1'}
    sequence(:email) { |i| "test#{i}@test.com" }
    password{ 'password1' }
    association(:company)
    confirmed_at { DateTime.now }


    trait :sysAdmin do
      association :user_role, factory: :sysAdmin_role
    end
  end
end
