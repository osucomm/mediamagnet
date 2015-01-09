FactoryGirl.define do
  factory :mapping do
    tag
    keyword

    trait :foo_to_department do
      tag         { FactoryGirl.create(:tag, :office) }
      keyword     { FactoryGirl.create(:keyword, :department) }
    end

  end

  factory :channel_mapping, parent: :mapping do
    mappable { |a| a.association(:channel) }
  end

  factory :entity_mapping, parent: :mapping do
    mappable { |a| a.association(:entity) }
  end

end
