FactoryGirl.define do
  factory :event do
    # item           { |a| a.association(:item) }
    location       { Faker::Address.street_address }
    starts_at      { rand(3.weeks).seconds.since }
    ends_at        { starts_at + rand(3.hour) }
  end
end
