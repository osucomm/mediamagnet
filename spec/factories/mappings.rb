FactoryGirl.define do
  factory :mapping do
    tag
    keyword
    mappable { |a| a.association(:channel) }
  end
end
