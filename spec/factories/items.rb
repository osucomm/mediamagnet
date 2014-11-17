FactoryGirl.define do
  factory :item do
    name              { Faker::Internet.domain_word }
    display_name      { Faker::Internet.domain_word }
    description       { Faker::Lorem.sentence(1) }
    category          { [0..3].sample }
  end
end
