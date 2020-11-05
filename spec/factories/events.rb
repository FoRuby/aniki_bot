FactoryBot.define do
  factory :event do
    name { Faker::Space.star }
    date { Time.zone.now }
  end
end
