FactoryBot.define do
  factory :note do
    message { Faker::Lorem.sentence }
    association :user
  end
end
