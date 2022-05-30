FactoryBot.define do
  factory :company do
    sequence(:email) { |i| "test#{i}@test.com" }
    sequence(:name) { |i| "test#{i}" }
    address{'test'}
    phone {'testPassword'}
  end
end
