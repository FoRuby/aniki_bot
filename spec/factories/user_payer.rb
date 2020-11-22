FactoryBot.define do
  factory :user_payer do
    user
    payer { create :user }
    debt { Faker::Number.decimal(l_digits: 2) }
  end
end
