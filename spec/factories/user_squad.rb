FactoryBot.define do
  factory :user_squad do
    user
    squad

    admin { false }
  end
end

