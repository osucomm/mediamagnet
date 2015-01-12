require 'spec_helper'

describe Keywording do
  describe 'associations' do
    it { should belong_to :keyword }
  end

  describe 'creation' do
    let(:channel)    { FactoryGirl.create(:twitter_channel, :with_items) }
    let(:entity)    { FactoryGirl.create(:entity) }
    let(:keyword)    { FactoryGirl.create(:keyword) }

    it 'on channel adds keyword to child items' do
      channel.keywords << keyword
      expect(channel.items.first.keywords).to include(keyword)
    end

    it 'on entity adds keyword to child items' do
      entity.channels << channel
      channel.keywords << keyword
      expect(entity.items.first.keywords).to include(keyword)
    end
  end

  describe 'destruction' do
    let(:channel)    { FactoryGirl.create(:twitter_channel, :with_items) }
    let(:entity)    { FactoryGirl.create(:entity) }
    let(:keyword)    { FactoryGirl.create(:keyword) }

    it 'on channel removes keyword to child items' do
      channel.add_keyword(keyword)
      channel.remove_keyword(keyword)
      expect(channel.items.first.keywords).to_not include(keyword)
    end

    it 'on entity removes keyword to child items' do
      entity.add_keyword(keyword)
      entity.remove_keyword(keyword)
      expect(entity.items.first.keywords).to_not include(keyword)
    end

  end


end
