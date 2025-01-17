require 'swagger_helper'

RSpec.describe 'api/v1/auth', type: :request do
  path '/api/v1/auth/assign_roles' do
    post('assign roles') do
      tags "Auth and Authorization"
      security [ Bearer: [] ]

      consumes 'application/json'
      parameter name: :role, in: :body, schema: {
        type: :object,
        properties: {
          user_id: { type: :integer, description: "user_id", example: 1 },
          role_ids: {
            type: :array,
            description: "role_ids",
            items: { type: :integer },
            example: [ 1, 2, 3, 4, 5 ]
          }
        }
      }

      response(200, 'successful') do
        let(:Authorization) { "token" }
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end

  path '/api/v1/auth/login' do
    post('login') do
      tags "Auth and Authorization"

      consumes 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          username: { type: :string, description: "username", example: "username" },
          password: { type: :string, description: "password", example: "password" }
        }
      }

      response(200, 'successful') do
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end

  path '/api/v1/auth/refresh_token' do
    post('refresh_token') do
      tags "Auth and Authorization"

      consumes 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          refresh_token: { type: :string, description: "refresh_token", example: "ebyfkjsdlkfj.sfksajdflkjsda;klfjk;liewfkljije" }
        }
      }

      response(200, 'successful') do
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end

  path '/api/v1/auth/assign_permissions' do
    post('assign roles') do
      tags "Auth and Authorization"
      security [ Bearer: [] ]

      consumes 'application/json'
      parameter name: :role, in: :body, schema: {
        type: :object,
        properties: {
          role_id: { type: :integer, description: "role_id", example: 1 },
          permission_ids: {
            type: :array,
            description: "permission_ids",
            items: { type: :integer },
            example: [ 1, 2, 3, 4, 5 ]
          }
        }
      }

      response(200, 'successful') do
        let(:Authorization) { "token" }
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end
end
