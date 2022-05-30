FactoryBot.define do
  factory :consignment do
    status {'Checked'}
    date {'11.11.2020'}
    truck_number {"test_number"}
    sequence(:bundle_seria){|i| "#seria#{i}"}
    sequence(:bundle_number){|i| "#number#{i}"}
    sequence(:consignment_number){|i| "#c-seria#{i}"}
    sequence(:consignment_seria){|i| "#c-number#{i}"}
    first_name {'test name'}
    second_name {"test surname"}
    passport {'test passport'}
    contractor_name {'test company'}
    placed_user_id {1}
    association(:user_id)
  end
end
