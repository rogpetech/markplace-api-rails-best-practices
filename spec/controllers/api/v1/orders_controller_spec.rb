require 'rails_helper'

RSpec.describe Api::V1::OrdersController, type: :controller do
  describe 'GET /index' do
    before(:each) do
      current_user = FactoryBot.create(:user)
      api_authorization_header(current_user.token)
      FactoryBot.create_list(:order, 4, user: current_user)
      get :index, params: { user_id: current_user.id }
    end

    it 'returns 4 order records from the user' do
      orders_response = json_response[:orders]
      expect(orders_response.count).to eq 4
    end

    it { should respond_with 200 }
  end

  describe '#GET #show' do
    before(:each) do
      current_user = FactoryBot.create(:user)
      api_authorization_header(current_user.token)
      @order = FactoryBot.create(:order, user: current_user)
      get :show, params: { user_id: current_user.id, id: @order.id }
    end

    it 'returns the user order record matching o id' do
      orders_response = json_response[:order]
      expect(orders_response[:id]).to eql @order.id
    end

    it { should respond_with 200 }
  end
end
