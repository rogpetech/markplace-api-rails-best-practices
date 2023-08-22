module Api
  module V1
    class ProductsController < ApplicationController
      before_action :authenticate_with_token!, only: [:create]
      respond_to :json

      def index
        respond_with Product.all
      end

      def show
        respond_with Product.find(params[:id])
      end

      def create
        product = current_user.products.build(product_params)
        if product.save
          render json: product, status: 201, location: [:api, product]
        else
          render json: { errors: product.errors }, status: 422
        end
      end

      def update
        product = current_user.products.find(params[:id])

        if product.update(product_params)
          render json: product, status: 200, location: [:api, product]
        else
          render json: { errors: product.errors }, status: 422
        end
      end

      def destroy
        product = current_user.products.find(params[:id])
        product.destroy
        head 204
      end

     private

      def product_params
        params.require(:product).permit(:title, :price, :published)
      end
    end
  end
end
