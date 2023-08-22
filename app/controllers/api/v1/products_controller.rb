module Api
  module V1
    class ProductsController < ApplicationController
      respond_to :json

      def show
        respond_with Product.find(params[:id])
      end
    end
  end
end
