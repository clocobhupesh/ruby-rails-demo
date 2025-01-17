require 'swagger_helper'

RSpec.describe 'api/v1/artists', type: :request do
  path '/api/v1/artists' do
    get('list artists') do
      tags "Artist"
      security [ Bearer: [] ]

      parameter name: :page, in: :query, type: :integer, required: false, 
              description: 'Page number for pagination', example: 1
      parameter name: :per_page, in: :query, type: :integer, required: false, 
              description: 'Number of items per page', example: 10

      response(200, 'successful') do
        let(:Authorization) { "token" }
        let(:page) { 1 }
        let(:per_page) { 10 }
        after do |payload|
          payload.metadata[:response][:content] = {
            'application/json' => {
              payload: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end

    post('create artist') do
      tags "Artist"
      security [ Bearer: [] ]
      consumes 'application/json'
      parameter name: :artist, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string, description: 'Name of the artist', example: 'example name' },
          bio: { type: :string, description: 'Bio of the artist', example: 'example bio' }
        },
        required: [ 'name' ]
      }

      response(201, 'successful') do
        let(:Authorization) { "token" }
        after do |payload|
          payload.metadata[:response][:content] = {
            'application/json' => {
              payload: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end

  path '/api/v1/artists/{id}' do
    # You'll want to customize the parameter types...
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('show artist') do
      tags "Artist"
      security [ Bearer: [] ]

      response(200, 'successful') do
        let(:Authorization) { "token" }
        let(:id) { '123' }
        
        after do |payload|
          payload.metadata[:response][:content] = {
            'application/json' => {
              payload: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end

    patch('update artist') do
      tags "Artist"
      security [ Bearer: [] ]

      consumes 'application/json'
      parameter name: :artist, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string, description: 'Name of the artist', example: 'example name' },
          bio: { type: :string, description: 'Bio of the artist', example: 'example bio' }
        },
        required: [ 'name' ]
      }
      response(200, 'successful') do
        let(:Authorization) { "token" }
        let(:id) { '123' }
        
        after do |payload|
          payload.metadata[:response][:content] = {
            'application/json' => {
              payload: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end

    put('update artist') do
      tags "Artist"
      security [ Bearer: [] ]
      consumes 'application/json'
      parameter name: :artist, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string, description: 'Name of the artist', example: 'example name' },
          bio: { type: :string, description: 'Bio of the artist', example: 'example bio' }
        },
        required: [ 'name' ]
      }
      response(200, 'successful') do
        let(:id) { '123' }
        let(:Authorization) { "token" }

        after do |payload|
          payload.metadata[:response][:content] = {
            'application/json' => {
              payload: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end

    delete('delete artist') do
      tags "Artist"
      security [ Bearer: [] ]
      
      response(200, 'successful') do
        let(:Authorization) { "token" }
        let(:id) { '123' }
        after do |payload|
          payload.metadata[:response][:content] = {
            'application/json' => {
              payload: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end
end
