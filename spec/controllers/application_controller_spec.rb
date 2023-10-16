require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  controller do
    def index
      raise ActiveRecord::RecordInvalid.new(User.new) if exception_class == ActiveRecord::RecordInvalid
      raise exception_class, 'Test Error Message' if exception_class
      render json: { message: 'Sucesso' }
    end

    private

    def exception_class
      params[:exception_class]&.constantize
    end
  end

  describe "error handling" do
    it 'Handles RecordNotFound errors' do
      get :index, params: { exception_class: "ActiveRecord::RecordNotFound" }

      expect(response).to have_http_status(:not_found)
      expect(json_response[:error]).to eq('Test Error Message')
    end

    it 'Handles record invalid errors' do
      get :index, params: { exception_class: "ActiveRecord::RecordInvalid" }
      expect(response).to have_http_status(:unprocessable_entity)
      expect(json_response[:error]).to eq('Validation failed: ')
    end
  end
end
