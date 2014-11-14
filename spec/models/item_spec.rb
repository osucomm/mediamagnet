require 'spec_helper'

describe Item do
  describe 'associations' do
  end

  describe '#tag_names' do
    let(:item) { FactoryGirl.create(:item) }

    it 'should have create and assign a new tag by that name' do
      item.tag_names = ['sdf']
      expect(item.tags.first.name).to eql('sdf')
    end

    it 'should have a tag by that name' do
      item.tag_names = ['ad']
      item.tag_names = ['asd']
      expect(item.tags.first.name).to eql('asd')
    end

    it 'should be able to accept nil' do
      item.tag_names = nil
      expect(item.tags.count).to eql(0)
    end
  end

end
