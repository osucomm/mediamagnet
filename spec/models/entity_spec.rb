require 'spec_helper'

describe Entity do
  let(:entity) { FactoryGirl.create(:entity) }

  describe 'associations' do
    it { should have_many :mappings }
    it { should respond_to :channels_mappings }
  end


  context '#has_user?' do
    let(:user) { FactoryGirl.create(:user) }

    it 'should return true when the user is a member of the entity' do
      entity.users << user
      expect(entity.has_user?(user)).to eql(true)
    end

    it 'should return false when the user is not a member of the entity' do
      expect(entity.has_user?(user)).to eql(false)
    end
  end

end
