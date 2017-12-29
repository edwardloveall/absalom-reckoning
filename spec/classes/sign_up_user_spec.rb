require 'rails_helper'

describe SignUpUser do
  describe '#perform' do
    it 'calls #create_user' do
      sign_up_user = SignUpUser.new
      allow(sign_up_user).to receive(:create_user)

      sign_up_user.perform({})

      expect(sign_up_user).to have_received(:create_user)
    end

    it 'calls #create_initial_calendar' do
      sign_up_user = SignUpUser.new
      allow(sign_up_user).to receive(:create_initial_calendar)

      sign_up_user.perform({})

      expect(sign_up_user).to have_received(:create_initial_calendar)
    end

    it 'returns a user' do
      sign_up_user = SignUpUser.new

      result = sign_up_user.perform(attributes_for(:user))

      expect(result).to be_a(User)
    end
  end

  describe '#create_user' do
    it 'uses Oath to create a user' do
      service = double(:sign_up)
      allow(Oath::Services::SignUp).to receive(:new).and_return(service)
      allow(service).to receive(:perform)

      SignUpUser.new.create_user({})

      expect(service).to have_received(:perform)
    end
  end

  describe '#create_initial_calendar' do
    it 'creates an owner permission' do
      permission_count = Permission.count
      user = create(:user)

      SignUpUser.new.create_initial_calendar(user: user)
      user.reload

      expect(user.permissions.first[:level]).to eq('owner')
      expect(Permission.count).to eq(permission_count + 1)
    end

    it 'creates a calendar for the user' do
      user = create(:user)
      calendar_count = user.calendars.count

      SignUpUser.new.create_initial_calendar(user: user)
      user.reload

      expect(user.calendars.count).to eq(calendar_count + 1)
    end

    it 'returns a calendar' do
      user = create(:user)

      result = SignUpUser.new.create_initial_calendar(user: user)

      expect(result).to be_a(Calendar)
    end
  end
end
