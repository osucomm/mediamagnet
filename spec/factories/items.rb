FactoryGirl.define do
  factory :item do
    title     { Faker::Internet.domain_word }
    guid      { Faker::Internet.domain_word }
    channel
  end
end
