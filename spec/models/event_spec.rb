require 'rails_helper'

RSpec.describe Event do
  describe 'validations' do
    it { should validate_presence_of(:occurred_on) }
    it { should validate_presence_of(:title) }
  end
end
