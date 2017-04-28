require 'rails_helper'

RSpec.describe Permission do
  describe 'associations' do
    it { should belong_to :calendar }
    it { should belong_to :user }
  end

  describe 'validations' do
    it { should validate_presence_of(:calendar) }
    it { should validate_presence_of(:level) }
    it do
      should validate_inclusion_of(:level).in_array(Permission::LEVELS.values)
    end
    it { should validate_presence_of(:user) }
  end
end
