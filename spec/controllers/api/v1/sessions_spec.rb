require 'rails_helper'

RSpec.describe Api::V1::SessionsController, type: :controller do
  describe 'POST #create' do
    before(:each) do
      @user = FactoryBot.create(:user)
    end

    context 'when the crendetials are correct' do
      before(:each) do
        credentials = { email: @user.email, password: @user.password }
        post :create, params: { session: credentials }
      end

      it 'returns the user record corresponding to the given credentiaisl' do
        @user.reload
        expect(json_response[:token]).to eql @user.token
      end

      it { should respond_with 200 }
    end

    context 'when the crentials are incorrect' do
      before(:each) do
        crendetials = { email: @user.email, password: 'invalid@password' }
        post :create, params: { session: crendetials }
      end

      it 'returns a json with an error' do
        expect(json_response[:errors]).to eql 'Invalid email or password'
      end

      it { should respond_with 422 }
    end
  end

  describe 'DELETE #destroy' do
    before(:each) do
      @user = FactoryBot.create(:user)
      sign_in(@user)
      delete :destroy, params: { id: @user.token }
    end

    it { should respond_with 204 }
  end
end
