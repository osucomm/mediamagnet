FactoryGirl.define do
  factory :keyword do
    name              { Faker::Internet.domain_word }
    display_name      { Faker::Internet.domain_word }
    description       { Faker::Lorem.sentence(1) }
    category          { 'location' }

    trait :department do
      name "Department"
    end

  end
end
