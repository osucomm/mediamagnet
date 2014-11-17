FactoryGirl.define do
  factory :tag do
    name              { Faker::Internet.domain_word }
  end
end
