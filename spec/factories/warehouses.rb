FactoryBot.define do
  factory :warehouse do
    name {'testWarehouse'}
    active {true }
    address {'testAddress'}
    area {'100500'}
    phone {'+375 33 333 333'}
    association(:company)
  end
  end
