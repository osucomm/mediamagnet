require 'spec_helper'

describe Channel do
  describe 'associations' do
    it { should have_many :channel_mappings }
    it { should respond_to :entity_mappings }
  end

end
