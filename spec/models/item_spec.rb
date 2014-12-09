require 'spec_helper'

describe Item do
  describe 'associations' do
  end

  context 'links' do
    let(:item) { FactoryGirl.create(:item, 
                                    title: 'https://google.com') }

    it 'should have associated link' do
      expect(item.links.count).to eql(1)
    end 
  end

end
