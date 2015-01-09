FactoryGirl.define do
  factory :channel do
    name                  { Faker::Internet.domain_word }

  end

  factory :twitter_channel, parent: :channel do
    service_identifier    { '@' + Faker::Name.last_name }

    trait :with_mappings do
      after(:create) do |channel, evaluator|
        create(:channel_mapping, :foo_to_department, mappable: channel)
      end
    end
  end


end
