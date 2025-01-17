require 'swagger_helper'

RSpec.describe 'api/v1/songs', type: :request do
  path '/api/v1/songs' do
    get('list songs') do
      tags "Songs"
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

    post('create song') do
      tags "Songs"
      security [ Bearer: [] ]

      consumes 'application/json'
      parameter name: :song, in: :body, schema: {
        type: :object,
        properties: {
          title: { type: :string, description: "Name of the song", "example": "song_name" },
          artist_id: { type: :integer  }
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

  path '/api/v1/songs/{id}' do
    # You'll want to customize the parameter types...
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('show song') do
      tags "Songs"
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

    patch('update song') do
      tags "Songs"
      security [ Bearer: [] ]

      consumes 'application/json'
      parameter name: :song, in: :body, schema: {
        type: :object,
        properties: {
          title: { type: :string, description: "Name of the song", "example": "song_name" },
          artist_id: { type: :integer  }
        }
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

    put('update song') do
      tags "Songs"
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

    delete('delete song') do
      tags "Songs"
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
