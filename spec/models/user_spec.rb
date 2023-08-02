require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryBot.build(:user) }

  subject { user }

  describe 'when respond to email, password, etc ' do
    it { should respond_to(:email) }
    it { should respond_to(:password) }
    it { should respond_to(:password_confirmation) }
    it { should respond_to(:token) }
  end

  describe 'when email is present' do
    it { should be_valid }
  end

  describe 'when email is not present' do
    it { should validate_uniqueness_of(:email).ignoring_case_sensitivity }
    it { should validate_confirmation_of(:password) }
    it { should validate_presence_of(:email) }
    it { should allow_value('email@domain.com').for(:email) }
    it { should validate_uniqueness_of(:token) }
  end

  describe '#geneate_authetication_token!' do
    it 'generates a unique token' do
      token = 'r0lf025125azsz5s51sa'
      allow(Devise).to receive(:friendly_token).and_return(token)
      user.geneate_authetication_token!
      expect(user.token).to eql(token)
    end

    it 'generates another token when one has been taken' do
      exists_user = FactoryBot.create(:user, token: 'r0lf155125azsz5s51sa')
      user.geneate_authetication_token!
      expect(user.token).not_to eql exists_user.token
    end
  end
end
