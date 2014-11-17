require 'spec_helper'

describe Entity do
  describe 'associations' do
    it { should have_many :entity_mappings }
    it { should respond_to :channels_mappings }
  end

end
