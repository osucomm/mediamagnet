FactoryGirl.define do

  factory :keywording do
    keyword

    trait :on_item do
      keywordable         { FactoryGirl.define(:item, :with_channel) }
    end

    trait :on_channel do
      keywordable         { FactoryGirl.define(:channel) }
    end
  end

end
