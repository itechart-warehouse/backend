FactoryBot.define do
    factory :user_role do
      sequence(:name) { |i| "role_#{i}" }

      trait :sysAdmin do
        name { 'System admin' }
        code { 'sadmin' }
      end

      trait :admin do
        name { 'Warehouse admin' }
        code { 'wadmin' }
      end

      trait :inspector do
        name { 'Inspector' }
        code { 'inspector' }
      end

      factory :sysAdmin_role, traits: [:sysAdmin]
      factory :admin_role, traits: [:admin]
      factory :inspector_role, traits: [:inspector]
    end
end
