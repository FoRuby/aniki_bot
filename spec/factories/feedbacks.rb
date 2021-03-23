FactoryBot.define do
  factory :feedback do
    message { Faker::Books::Lovecraft.paragraph }
    user
  end
end
