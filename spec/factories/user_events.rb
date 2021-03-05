FactoryBot.define do
  factory :user_event do
    user
    event

    payment { 0 }
  end

  trait :with_payment do
    payment { 300 }
  end
end
