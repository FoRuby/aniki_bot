FactoryBot.define do
  factory :refill do
    debt { debt }
    value { 300 }
    status { :created }
  end
end
