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
      @product = FactoryBot.create(:product)
      @order = FactoryBot.create(:order, user: current_user)
      get :show, params: { user_id: current_user.id, id: @order.id, product_ids: [@product.id] }
    end

    it 'returns the total for the order payload' do
      order_response = json_response[:order]
      expect(order_response[:total]).to eql @order.total.to_s
    end

    it 'returns the user order record matching o id' do
      orders_response = json_response[:order]
      expect(orders_response[:id]).to eql @order.id
    end

    it { should respond_with 200 }
  end

  describe '#POST #create' do
    before(:each) do
      current_user = FactoryBot.create(:user)
      api_authorization_header(current_user.token)

      product_1 = FactoryBot.create(:product)
      product_2 = FactoryBot.create(:product)
      order_params = { product_ids_and_quantities: [[product_1.id, 2], [product_2.id, 4]] }
      post :create, params: { user_id: current_user.id, order: order_params }
    end

    it 'returns the just user order record' do
      order_response = json_response[:order]
      expect(order_response[:id]).to be_present
    end

    it "embeds the two products objects related to the order" do
      order_response = json_response[:products]
      expect(order_response.size).to eql 2
    end

    it { should respond_with 201 }
  end
end
