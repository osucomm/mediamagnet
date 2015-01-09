require 'spec_helper'

describe User do

  context '#is_admin?' do
    let(:user) { create(:user) }
    let(:admin_user) { create(:user, :is_admin) }

    it 'returns true when user is an admin' do
      expect(admin_user.is_admin?).to eql(true)
    end

    it 'returns false when user is not an admin' do
      expect(user.is_admin?).to eql(false)
    end
  end

  describe 'display name' do
    let(:user) { create(:user) }
    let(:user_without_name) { create(:user, :without_name) }

    it 'is the full name if present' do
      expect(user.display_name).to eql(user.fullname)
    end

    it 'is the username when there is no full name' do
      expect(user_without_name.display_name).to eql(user_without_name.username)
    end
  end

end
