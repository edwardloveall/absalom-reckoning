require 'rails_helper'

RSpec.describe User do
  describe 'validations' do
    subject { create(:user) }

    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
    it { should validate_presence_of(:password_digest) }
  end
end