require 'spec_helper'

describe Item do
  before(:all) do
  end

  describe 'associations' do
  end

  context 'links' do
    let(:item) { FactoryGirl.create(:item,
                                    title: 'https://google.com') }

    it 'should have associated link' do
      expect(item.links.count).to eql(1)
    end 
  end

  context 'keywords' do
    let(:item_without_tags) { FactoryGirl.create(:item) }
    let(:item_with_tags) { FactoryGirl.create(:item, :with_tags) }
    let(:item_with_mappings) { FactoryGirl.create(:item, :with_channel_mappings, :with_tags) }
    let(:keyword) { FactoryGirl.create(:keyword) }

    it 'should allow duplicates and only remove top of stack' do
      keyword = FactoryGirl.create(:keyword, :department)
      item_without_tags.keywords << keyword
      item_without_tags.keywords << keyword
      item_without_tags.remove_keyword(keyword)
      expect(item_without_tags.keywords).to include(keyword)
    end

    it 'should report count of distinct keywords' do
      item_without_tags.keywords << keyword
      item_without_tags.keywords << keyword
      expect(item_without_tags.distinct_keywords.count).to eql(1)
    end

    it 'should be assigned a keyword with the same name if it exists' do
      keyword = FactoryGirl.create(:keyword, :department)
      expect(item_with_tags.tags.first.name).to eql(keyword.name)
    end

    it 'should be not be assigned a keyword if it has no tags' do
      expect(item_without_tags.keywords.count).to eql(0)
    end

    it 'should be assigned a keyword from a mapping if it has the tag from the mapping' do
      keyword_from_mapping = item_with_mappings.channel.mappings.first.keyword
      keyword_from_item = item_with_mappings.keywords.first
      expect(keyword_from_item).to eql(keyword_from_mapping)
    end

  end

end
