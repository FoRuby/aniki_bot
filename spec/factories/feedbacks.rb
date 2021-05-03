FactoryBot.define do
  factory :feedback do
    message { Faker::Books::Lovecraft.paragraph }
    user

    trait :empty do
      message { '' }
    end
  end
end
