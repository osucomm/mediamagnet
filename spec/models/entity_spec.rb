require 'spec_helper'

describe Entity do
  describe 'associations' do
    it { should have_many :entity_mappings }
    it { should respond_to :channels_mappings }
  end

  #
  describe '#has_user?' do
    let(:entity) { FactoryGirl.create(:entity) }
    let(:user)   { FactoryGirl.create(:user) }

    it 'should return false when the user is a member of the entity' do
      expect(entity.has_user?(user)).to eql(false)
    end

    it 'should return true when the user is a member of the entity' do
      entity.users << user
      expect(entity.has_user?(user)).to eql(true)
    end


  end

end
