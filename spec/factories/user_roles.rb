FactoryBot.define do
  factory :user_role do
    trait :sysAdmin do
      code {'sadmin'}
      name {'System admin'}
    end
    factory :sysAdmin_role, traits: [:sysAdmin]
  end
end
