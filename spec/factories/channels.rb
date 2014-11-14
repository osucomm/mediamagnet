FactoryGirl.define do
  factory :channel do
    type                  { 'TwitterChannel' }
    name                  { Faker::Internet.domain_word }
    service_identifier    { '@' + Faker::Name.last_name }
  end
end
