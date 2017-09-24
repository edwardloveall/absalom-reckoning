require 'rails_helper'

RSpec.describe Invitation do
  describe 'associations' do
    it { should belong_to(:calendar) }
    it { should belong_to(:owner).class_name('User') }
  end

  describe 'validations' do
    it { should validate_presence_of(:calendar) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:owner) }
  end
end
