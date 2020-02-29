FactoryBot.define do
  factory :user do
    first_name { 'Maciej' }
    last_name { 'Sypniewski' }
    sequence(:email) { |n| "emai#{n}@gmail.com" }
    password { 'password' }
  end
end
