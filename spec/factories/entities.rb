FactoryGirl.define do
  factory :entity do
    name                  { Faker::Internet.domain_word }
    description           { Faker::Lorem.sentence(1) }
    link                  { Faker::Internet.url }
  end
end
