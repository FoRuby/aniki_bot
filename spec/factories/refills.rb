FactoryBot.define do
  factory :refill do
    association :debt, factory: :debt
    value { 300 }
    status { :created }
  end
end
