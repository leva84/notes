FactoryBot.define do
  factory :user do
    first_name { 'First_name' }
    last_name  { 'Last_name' }
    email { Faker::Internet.email }
    password { 'password' }
    password_confirmation { 'password' }
  end
end
