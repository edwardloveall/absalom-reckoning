require 'rails_helper'

RSpec.describe User do
  describe 'associations' do
    it { should have_many(:permissions) }
    it { should have_many(:calendars).through(:permissions) }
  end

  describe 'validations' do
    subject { create(:user) }

    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
    it { should validate_presence_of(:password_digest) }
  end

  describe 'permissions' do
    describe '#can_own?' do
      it 'returns true for calendars owned by the user' do
        user = create(:user)
        calendar = create(:calendar)
        create(:permission, :owner, user: user, calendar: calendar)

        can_own = user.can_own?(calendar)

        expect(can_own).to be_truthy
      end

      it 'returns false for calendars with no permission' do
        user = create(:user)
        calendar = create(:calendar)

        can_own = user.can_own?(calendar)

        expect(can_own).to be_falsey
      end

      it 'returns false for calendars with edit or view permission' do
        user = create(:user)
        edit_calendar = create(:calendar)
        view_calendar = create(:calendar)
        create(:permission, :editor, user: user, calendar: edit_calendar)
        create(:permission, :viewer, user: user, calendar: view_calendar)

        can_own_edit = user.can_own?(edit_calendar)
        can_own_view = user.can_own?(view_calendar)

        expect(can_own_edit).to be_falsey
        expect(can_own_view).to be_falsey
      end
    end

    describe '#can_edit?' do
      it 'returns true for calendars that have an owner or editor permission' do
        user = create(:user)
        own_calendar = create(:calendar)
        edit_calendar = create(:calendar)
        create(:permission, :owner, user: user, calendar: own_calendar)
        create(:permission, :editor, user: user, calendar: edit_calendar)

        can_edit_own = user.can_edit?(own_calendar)
        can_edit_edit = user.can_edit?(edit_calendar)

        expect(can_edit_own).to be_truthy
        expect(can_edit_edit).to be_truthy
      end

      it 'returns false with no permissions' do
        user = create(:user)
        calendar = create(:calendar)

        can_edit = user.can_edit?(calendar)

        expect(can_edit).to be_falsey
      end

      it 'returns false with view permissions' do
        user = create(:user)
        calendar = create(:calendar)
        create(:permission, :viewer, user: user, calendar: calendar)

        can_edit = user.can_edit?(calendar)

        expect(can_edit).to be_falsey
      end
    end

    describe '#can_view?' do
      it 'returns true if user has own, edit, or view permission' do
        user = create(:user)
        own_calendar = create(:calendar)
        edit_calendar = create(:calendar)
        view_calendar = create(:calendar)
        create(:permission, :owner, user: user, calendar: own_calendar)
        create(:permission, :editor, user: user, calendar: edit_calendar)
        create(:permission, :viewer, user: user, calendar: view_calendar)

        can_view_own = user.can_view?(own_calendar)
        can_view_edit = user.can_view?(edit_calendar)
        can_view_view = user.can_view?(view_calendar)

        expect(can_view_own).to be_truthy
        expect(can_view_edit).to be_truthy
        expect(can_view_view).to be_truthy
      end

      it 'returns false if there are no permissions' do
        user = create(:user)
        calendar = create(:calendar)

        can_view = user.can_view?(calendar)

        expect(can_view).to be_falsey
      end
    end
  end
end
