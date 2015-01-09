FactoryGirl.define do
  factory :user do
    username      { Faker::Internet.user_name }
    email         { Faker::Internet.email }
    fullname      { Faker::Name.name }
    password      { '123abc123' }
    password_confirmation      { '123abc123' }

    trait :is_admin do
      admin { true }
    end

    trait :is_blocked do
      blocked { true }
    end

    trait :without_name do
      fullname { nil }
    end

  end
end
