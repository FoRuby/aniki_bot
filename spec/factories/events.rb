FactoryBot.define do
  factory :event do
    name { Faker::Space.star }
    date { (Time.now + 1.day).strftime('%F %H:%M') }

    trait :close do
      status { :close }
    end

    trait :past do
      date { (Time.now - 1.day).strftime('%F %H:%M') }
    end
  end
end
