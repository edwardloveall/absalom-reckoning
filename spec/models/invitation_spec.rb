require 'rails_helper'

RSpec.describe Invitation do
  describe 'associations' do
    it { should belong_to(:calendar) }
    it { should belong_to(:owner).class_name('User') }
  end

  describe 'validations' do
    it { should validate_presence_of(:calendar) }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).scoped_to(:calendar_id) }
    it { should validate_presence_of(:level) }
    it do
      levels = Permission::INVITATION_LEVELS
      should validate_inclusion_of(:level).in_array(levels)
    end
    it { should validate_presence_of(:owner) }
  end

  describe '#accept!' do
    it 'sets the accepted_at attribute to the current datetime' do
      invitation = create(:invitation, accepted_at: nil)

      invitation.accept!

      expect(invitation.accepted_at).to be_a(ActiveSupport::TimeWithZone)
    end
  end
end
