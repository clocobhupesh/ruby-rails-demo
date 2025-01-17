require 'swagger_helper'

RSpec.describe 'api/v1/roles', type: :request do
  path '/api/v1/roles' do
    get('list roles') do
      tags "Roles"
      security [ Bearer: [] ]
      produces 'application/json'
      
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

    post('create role') do
      tags "Roles"
      security [ Bearer: [] ]
      consumes 'application/json'
      produces 'application/json'
      
      parameter name: :role, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string, example: 'name' },
          description: { type: :string, example: 'description' },
        },
        required: ['name', 'description']
      }
    
      response(200, 'successful') do
        let(:Authorization) { "token" }
        let(:role) { { name: 'test role', description: 'test description' } }
        
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

  path '/api/v1/roles/{id}' do
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('show role') do
      tags "Roles"
      security [ Bearer: [] ]
      produces 'application/json'
      
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

    patch('update role') do
      tags "Roles"
      security [ Bearer: [] ]
      consumes 'application/json'
      produces 'application/json'
      
      parameter name: :role, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string, example: 'name' },
          description: { type: :string, example: 'description' },
        },
        required: ['name', 'description']
      }
    
      response(200, 'successful') do
        let(:Authorization) { "token" }
        let(:id) { '123' }
        let(:role) { { name: 'updated role', description: 'updated description' } }
        
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
    
    put('update role') do
      tags "Roles"
      security [ Bearer: [] ]
      consumes 'application/json'
      produces 'application/json'
      
      parameter name: :role, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string, example: 'name' },
          description: { type: :string, example: 'description' },
        },
        required: ['name', 'description']
      }
    
      response(200, 'successful') do
        let(:Authorization) { "token" }
        let(:id) { '123' }
        let(:role) { { name: 'updated role', description: 'updated description' } }
        
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

    delete('delete role') do
      tags "Roles"
      security [ Bearer: [] ]
      produces 'application/json'
      
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