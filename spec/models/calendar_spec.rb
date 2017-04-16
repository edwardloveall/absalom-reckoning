require 'rails_helper'

RSpec.describe Calendar do
  describe 'associations' do
    it { should have_many(:events) }
  end
end
