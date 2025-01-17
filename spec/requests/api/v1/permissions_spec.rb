require 'swagger_helper'

RSpec.describe 'api/v1/permissions', type: :request do
  path '/api/v1/permissions' do
    get('list permissions') do
      tags "Permissions"
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

    post('create permission') do
      tags "Permissions"
      security [ Bearer: [] ]
      
      consumes 'application/json'
      produces 'application/json'
      
      parameter name: :permission, in: :body, schema: {
        type: :object,
        properties: {
          action: { type: :string, example: 'create' },
          resource: { type: :string, example: 'artist' },
        },
        required: ['action', 'resource']
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
  

  path '/api/v1/permissions/{id}' do
    # You'll want to customize the parameter types...
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('show permission') do
      tags "Permissions"
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

    patch('update permission') do
      tags "Permissions"
      security [ Bearer: [] ]
      
      consumes 'application/json'
      produces 'application/json'
      
      parameter name: :permission, in: :body, schema: {
        type: :object,
        properties: {
          action: { type: :string, example: 'create' },
          resource: { type: :string, example: 'artist' },
        },
        required: ['action', 'resource']
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
    
    put('update permission') do
      tags "Permissions"
      security [ Bearer: [] ]
      
      consumes 'application/json'
      produces 'application/json'
      
      parameter name: :permission, in: :body, schema: {
        type: :object,
        properties: {
          action: { type: :string, example: 'create' },
          resource: { type: :string, example: 'artist' },
        },
        required: ['action', 'resource']
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


    delete('delete permission') do
      tags "Permissions"
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
