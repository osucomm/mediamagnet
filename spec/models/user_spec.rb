require 'spec_helper'

describe User do
  describe 'associations' do
    it { should have_many entities }
    it { should have_many eties }
  end
end
