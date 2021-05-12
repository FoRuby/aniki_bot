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

    trait :with_admin do
      transient do
        user { create :user, :admin }
      end

      after(:create) do |event, evaluator|
        create :user_event, :admin, event: event, user: evaluator.user
      end
    end
  end
end
