FactoryBot.define do
  factory :user_event do
    user
    event

    payment { 300 }
    admin { false }
  end
end
