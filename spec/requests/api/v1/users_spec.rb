require 'swagger_helper'

RSpec.describe 'api/v1/users', type: :request do
  path '/api/v1/users' do
    get('list users') do
      tags "Users"
      security [ Bearer: [] ]

      parameter name: :page, in: :query, type: :integer, required: false,
              description: 'Page number for pagination', example: 1
      parameter name: :per_page, in: :query, type: :integer, required: false,
              description: 'Number of items per page', example: 10

      response(200, 'successful') do
        let(:Authorization) { "token" }
        let(:page) { 1 }
        let(:per_page) { 10 }
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

    post('create user') do
      tags "Users"
      security [ Bearer: [] ]

      consumes 'application/json'
      produces 'application/json'

      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          username: { type: :string, example: 'username' },
          password: { type: :string, example: 'password' },
          firstname: { type: :string, example: 'firstname' },
          lastname: { type: :string, example: 'lastname' },
          email: { type: :string, example: 'email@gmail.com' }

        },
        required: [ 'username', 'password', 'lastname', 'lastname', 'email' ]
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

  path '/api/v1/users/{id}' do
    # You'll want to customize the parameter types...
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('show user') do
      tags "Users"
      security [ Bearer: [] ]

      response(200, 'successful') do
        let(:Authorization) { "token" }
        let(:id) { '123' }

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

    patch('update user') do
      tags "Users"
      security [ Bearer: [] ]

      consumes 'application/json'
      produces 'application/json'

      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          username: { type: :string, example: 'username' },
          password: { type: :string, example: 'password' },
          firstname: { type: :string, example: 'firstname' },
          lastname: { type: :string, example: 'lastname' },
          email: { type: :string, example: 'email@gmail.com' }

        },
        required: [ 'username', 'password' 'lastname', 'lastname', 'email' ]
      }

      response(200, 'successful') do
        let(:Authorization) { "token" }
        let(:id) { '123' }

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

    put('update user') do
      tags "Users"
      security [ Bearer: [] ]

      consumes 'application/json'
      produces 'application/json'

      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          username: { type: :string, example: 'username' },
          password: { type: :string, example: 'password' },
          firstname: { type: :string, example: 'firstname' },
          lastname: { type: :string, example: 'lastname' },
          email: { type: :string, example: 'email@gmail.com' }

        },
        required: [ 'username', 'password' 'lastname', 'lastname', 'email' ]
      }

      response(200, 'successful') do
        let(:Authorization) { "token" }
        let(:id) { '123' }

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

    delete('delete user') do
      tags "Users"
      security [ Bearer: [] ]

      response(200, 'successful') do
        let(:Authorization) { "token" }
        let(:id) { '123' }

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
