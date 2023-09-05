require 'swagger_helper'

RSpec.describe 'api/v1/products', type: :request do

  # GET Show
  path '/products/{id}' do
    get 'Retrieve a product' do
      tags 'API:V1::PRODUCTS'
      produces 'application/json'
      parameter name: :id, in: :path, type: :integer

      response '200', 'product found' do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 title: { type: :string }
               }

        let!(:id) { FactoryBot.create(:product).id }
        run_test!
      end
    end
  end

  # GET Index
  path '/products' do
    get 'List all products' do
      tags 'API:V1::PRODUCTS'
      produces 'application/json'

      response '200', 'products listed' do
        run_test!
      end
    end
  end

  # POST Create
  path '/products' do
    post 'Create a product' do
      tags 'API:V1::PRODUCTS'
      consumes 'application/json'
      parameter name: 'Authorization',
            in: :header,
            description: 'Authorization token',
            type: :string,
            required: true
      parameter name: :body,
                in: :body,
                schema: {
                  type: :object,
                  properties: {
                    product: {
                      type: :object,
                      properties: {
                        title: { type: :string },
                        price: { type: :number }
                      }
                    }
                  }
                }

      response '201', 'product created' do
        let!(:body) do
          {
            'product': {
              'title': 'Smart Tv',
              'price': 1200
            }
          }
        end
        let!(:'Authorization') { FactoryBot.create(:user).token }
        run_test!
      end

      response '422', 'invalid product' do
        let!(:body) do
          {
            'product': {
              'title': 'Smart Tv',
              'price': 'Twelve dollars'
            }
          }
        end
        let!(:Authorization) { FactoryBot.create(:user).token }
        run_test!
      end
    end
  end

  # PATCH/PUT Update
  path '/products/{id}' do
    patch 'Update a product' do
      tags 'API:V1::PRODUCTS'
      consumes 'application/json'
      parameter name: 'Authorization',
            in: :header,
            description: 'Authorization token',
            type: :string,
            required: true
      parameter name: :id, in: :path, type: :integer
      parameter name: :body, in: :body,
                schema: {
                  type: :object,
                  properties: {
                    product: {
                      type: :object,
                      properties: {
                        title: { type: :string },
                        price: { type: :number }
                      }
                    }
                  }
                }

      response '200', 'product updated' do
        let!(:id) { FactoryBot.create(:product).id }
        let!(:body) do
          {
            'product': {
              'title': 'An expensive TV',
              'price': 2000
            }
          }
        end
        run_test!
      end

      response '422', 'invalid product' do
        let!(:id) { FactoryBot.create(:product).id }
        let!(:body) do
          {
            'product': {
              'title': 'Smart Tv',
              'price': 'two hundred'
            }
          }
        end
        let!(:Authorization) { FactoryBot.create(:user).token }
        run_test!
      end
    end
  end

  # DELETE Destroy
  path '/products/{id}' do
    delete 'Delete a product' do
      tags 'API:V1::PRODUCTS'
      consumes 'application/json'
      parameter name: 'Authorization',
            in: :header,
            description: 'Authorization token',
            type: :string,
            required: true
      parameter name: :id, in: :path, type: :integer

      response '204', 'product deleted' do
        let!(:id) do 
          product = FactoryBot.create(:product)
          product.id
        end
        let!(:Authorization) { FactoryBot.create(:user).token }
        run_test!
      end
    end
  end

end
