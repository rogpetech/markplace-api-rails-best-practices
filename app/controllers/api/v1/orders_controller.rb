class Api::V1::OrdersController < ApplicationController
  before_action :authenticate_with_token!, only: [:index]
  respond_to :json

  def index
    respond_with orders: current_user.orders
  end
end
