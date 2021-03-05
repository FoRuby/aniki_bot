FactoryBot.define do
  factory :event do
    name { Faker::Space.star }
    date { (Time.now + 1.day).strftime('%F %H:%M') }

    trait :close do
      status { :close }
    end
  end
end
