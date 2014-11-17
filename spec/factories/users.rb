FactoryGirl.define do
  factory :user do
    username      { Faker::Internet.user_name }
    email         { Faker::Internet.email }
    fullname      { Faker::Name.name }
    password      { '123abc123' }
    password_confirmation      { '123abc123' }
  end
end
