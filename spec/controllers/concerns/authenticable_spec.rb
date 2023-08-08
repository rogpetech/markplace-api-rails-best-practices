require 'rails_helper'

class Authentication < ActionController::API
  include Authenticable
end

describe Authenticable do
  let(:authentication) { Authentication.new }
  subject { authentication }

  describe '#current_user' do
    before do
      @user = FactoryBot.create(:user)
      request.headers['Authorization'] = @user.token
      allow(authentication).to receive(:request).and_return(request)
    end

    it 'returns the user from the authorization header' do
      expect(authentication.current_user.token).to eql @user.token
    end
  end

  describe '#authenticate_with_token!' do
    before do
      @user = FactoryBot.create(:user)
      request.headers['Authorization'] = @user.token
      allow(authentication).to receive(:request).and_return(request)
      response.status = 401
      response.body = { 'errors': 'Not authenticated' }.to_json
      allow(authentication).to receive(:response).and_return(response)
    end

    it 'render a json error message' do
      expect(json_response[:errors]).to eql 'Not authenticated'
    end

    it { should respond_with 401 }
  end

  describe '#user_signed_in?' do
    context "when there is a user on ' session' " do
      before do
        @user = FactoryBot.create(:user)
        allow(authentication).to receive(:current_user).and_return(@user)
      end

      it { should be_user_signed_in }
    end

    context "when there is no user on 'session'" do
      before do
        @user = FactoryBot.create(:user)
        allow(authentication).to receive(:current_user).and_return(nil)
      end

      it { should_not be_user_signed_in }
    end
  end
end
