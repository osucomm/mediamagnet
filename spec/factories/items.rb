FactoryGirl.define do
  factory :item do
    guid              { Faker::Number.number(6) }
    title             { Faker::Internet.domain_word }
    description       { Faker::Lorem.sentence(1) }
    channel           { |a| a.association(:twitter_channel) }

    trait :with_tags do
      tags            {[FactoryGirl.create(:tag, name: 'department')]}
    end

    trait :with_channel_mappings do
      channel         { FactoryGirl.create(:twitter_channel, :with_mappings) }
    end

  end
end
