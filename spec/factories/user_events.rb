FactoryBot.define do
  factory :user_event do
    user
    event

    admin { false }
    payment_kopecks { Faker::Number.decimal(l_digits: 2) }
  end
end
