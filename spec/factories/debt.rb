FactoryBot.define do
  factory :debt do
    borrower { create :user }
    creditor { create :user }
    value { Faker::Number.decimal(l_digits: 2) }
    is_compensation { false }

    trait :with_compensation_flag do
      is_compensation { true }
    end
  end
end
