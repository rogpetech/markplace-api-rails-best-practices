require 'swagger_helper'

RSpec.describe 'api/v1/users', type: :request do
  path '/users/{id}' do
    get 'Retrivie a user' do
      tags 'API:V1::USERS'
      produces 'application/json'
      parameter name: 'Accept',
                in: :header,
                description: 'Add structure for version',
                type: :string
      parameter name: :id,
                in: :path,
                type: :string

      response '200', 'user found' do
        schema type: :object,
               properties: {
                id: { type: :integer },
                email: { type: :string },
                created_at: { type: :string },
                updated_at: { type: :string }
               }
        let!(:id) { FactoryBot.create(:user).id }
        let!(:Accept) { 'application/vnd.marketplace.v1' }

        run_test!
      end
    end
  end

  path '/users' do
    post 'Create a user' do
      tags 'API:V1::USERS'
      consumes 'application/json'
      parameter name: :body,
                in: :body,
                schema: {
                  type: :object,
                  properties: {
                    user: {
                      type: :object,
                      properties: {
                        email: { type: :string },
                        password: { type: :string },
                        password_confirmation: { type: :string }
                      }
                    }
                  }
                }

      response '201', 'create user' do
        let!(:body) do
          {
            'user': {
              'email': 'example@example.org',
              'password': '123456',
              'password_confirmation': '123456'
            }
          }
        end
        run_test!
      end
      response '422', 'create user error' do
        let!(:body) do
          {
            'email': 'example@example.org',
            'password': '123456',
            'password_confirmation': '123456'
          }
        end
        run_test!
      end
    end
  end

  path '/users/{id}' do
    delete 'Delete a user' do
      tags 'API:V1::USERS'
      consumes 'application/json'
      parameter name: :id, in: :path, type: :string

      response '204', 'user deleted' do
        let!(:id) { FactoryBot.create(:user).id }
        run_test!
      end

      # response '404', 'user not found' do
      #   let!(:id) { 2 }
      #   run_test!
      # end
    end
  end

  path '/users/{id}' do
    patch 'Update a user' do
      tags 'API:V1::USERS'
      consumes 'application/json'
      parameter name: :id, in: :path, type: :integer
      parameter name: :body, in: :body,
                schema: {
                  type: :object,
                  properties: {
                    user: {
                      type: :object,
                      properties: {
                        email: { type: :string },
                        password: { type: :string },
                        password_confirmation: { type: :string }
                      }
                    }
                  }
                }

      response '200', 'user updated' do
        let!(:id) { FactoryBot.create(:user).id }
        let!(:body) do
          {
            'user': {
              'email': 'example2@example.org',
              'password': '123456',
              'password_confirmation': '123456'
            }
          }
        end
        run_test!
      end

      # response '404', 'user not found' do
      #   let!(:id) { 2 }
      #   let!(:body) do
      #     {
      #       'user': {
      #         'email': 'example2@example.org',
      #         'password': '123456',
      #         'password_confirmation': '123456'
      #       }
      #     }
      #   end
      #   run_test!
      # end
    end
  end
end
