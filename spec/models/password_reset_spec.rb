require 'rails_helper'

RSpec.describe PasswordReset do
  describe 'associations' do
    it { should belong_to(:user) }
  end

  describe '#to_param' do
    it 'returns the token' do
      token = 'abc'
      reset = PasswordReset.new(token: token)

      expect(reset.to_param).to eq(token)
    end
  end

  describe 'callbacks' do
    describe 'generate_unique_token' do
      it 'generates a new token after the record is created' do
        user = create(:user)
        reset = PasswordReset.new

        expect(reset.token).to be_nil

        reset.user = user
        reset.save

        expect(reset.token).not_to be_nil
      end
    end
  end
end
