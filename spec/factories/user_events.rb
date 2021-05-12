FactoryBot.define do
  factory :user_event do
    user
    event
    payment { 0 }
  end

  trait :with_payment do
    payment { 300 }
  end

  trait :admin do
    after(:create) do |user_event|
      user_event.user.add_role :admin, user_event.event
    end
  end
end
