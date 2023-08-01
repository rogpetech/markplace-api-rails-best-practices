require 'swagger_helper'

RSpec.describe 'api/v1/users', type: :request do
  path '/users/{id}' do
    get 'Retrivies a users' do
      tags 'Api::V1::Users'
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

  # path '/users/{id}' do
  #   # You'll want to customize the parameter types...
  #   parameter name: 'id', in: :path, type: :string, description: 'id'

  #   get('show user') do
  #     response(200, 'successful') do
  #       let(:id) { '123' }

  #       after do |example|
  #         example.metadata[:response][:content] = {
  #           'application/json' => {
  #             example: JSON.parse(response.body, symbolize_names: true)
  #           }
  #         }
  #       end
  #       run_test!
  #     end
  #   end

  #   patch('update user') do
  #     response(200, 'successful') do
  #       let(:id) { '123' }

  #       after do |example|
  #         example.metadata[:response][:content] = {
  #           'application/json' => {
  #             example: JSON.parse(response.body, symbolize_names: true)
  #           }
  #         }
  #       end
  #       run_test!
  #     end
  #   end

  #   put('update user') do
  #     response(200, 'successful') do
  #       let(:id) { '123' }

  #       after do |example|
  #         example.metadata[:response][:content] = {
  #           'application/json' => {
  #             example: JSON.parse(response.body, symbolize_names: true)
  #           }
  #         }
  #       end
  #       run_test!
  #     end
  #   end

  #   delete('delete user') do
  #     response(200, 'successful') do
  #       let(:id) { '123' }

  #       after do |example|
  #         example.metadata[:response][:content] = {
  #           'application/json' => {
  #             example: JSON.parse(response.body, symbolize_names: true)
  #           }
  #         }
  #       end
  #       run_test!
  #     end
  #   end
  # end
end
