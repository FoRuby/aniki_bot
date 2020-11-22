FactoryBot.define do
  factory :user do
    first_name   { Faker::Name.first_name }
    last_name    { Faker::Name.last_name }
    username     { Faker::Internet.username }

    factory :aniki do
      first_name { 'Billy' }
      last_name  { 'Herrington' }
      username   { 'GachiBuhgalterBot' }
    end
  end
end
