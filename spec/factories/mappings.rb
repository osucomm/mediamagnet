FactoryGirl.define do
  factory :channel_mapping do
    tag
    keyword
    mappable { |a| a.association(:channel) }
  end
end
