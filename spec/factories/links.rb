FactoryGirl.define do
  factory :link do
    item           { |a| a.association(:channel) }
    link           { 'http://google.com' }
  end
end
