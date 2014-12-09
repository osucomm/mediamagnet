FactoryGirl.define do
  factory :item do
    title             { Faker::Internet.domain_word }
    description       { Faker::Lorem.sentence(1) }
    channel           { |a| a.association(:twitter_channel) }
    link              { |a| a.association(:link) }
  end
end
