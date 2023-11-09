class Api::V1::OrdersController < ApplicationController
  before_action :authenticate_with_token!, only: [:index, :show]
  respond_to :json

  def index
    respond_with orders: current_user.orders
  end

  def show
    respond_with(order: current_user.orders.find(params[:id]))
  end
end
