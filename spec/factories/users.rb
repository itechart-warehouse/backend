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
      user_role {create(:sysAdmin_role)}
    end

    trait :admin do
      user_role {create(:admin_role)}
      association(:warehouse_id)
    end

    trait :inspector do
      user_role {create(:inspector_role)}
    end

    factory :sysAdmin, traits: [:sysAdmin]
    factory :admin, traits: [:admin]
    factory :inspector, traits: [:inspector]

  end
end
