require 'spec_helper'

describe Mapping do
  describe 'associations' do
    it { should belong_to :tag }
  end

end
