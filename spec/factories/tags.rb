FactoryGirl.define do
  factory :tag do
    name              { Faker::Internet.domain_word }

    trait :office do
      name 'office'
    end
  end
end
