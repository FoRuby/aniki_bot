FactoryBot.define do
  factory :refill do
    from_user { create :user }
    to_user { create :user }
    value { 300 }
  end
end
