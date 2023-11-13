class Api::V1::OrdersController < ApplicationController
  before_action :authenticate_with_token!, only: [:index, :show]
  respond_to :json

  def index
    respond_with orders: current_user.orders
  end

  def show
    respond_with(order: current_user.orders.find(params[:id]))
  end

  def create
    order = current_user.orders.build(order_params)

    return render json: { errors: order.errors }, status: 422 unless order.save

    render json: { order: order }, status: 201
  end

  private

  def order_params
    params.require(:order).permit(:product_ids => [])
  end
end
