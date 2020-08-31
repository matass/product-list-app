# frozen_string_literal: true

RSpec.describe API::V1::TagsController, type: :request do
  describe 'GET /api/v1/tags' do
    it 'gets tags' do
      get '/api/v1/tags'

      expect(response.status).to eq(200)

      expect(parsed_data[0]['attributes']['title']).to eq('Beverage')
      expect(parsed_data[1]['attributes']['title']).to eq('Calorie Free')
    end
  end

  describe 'POST /api/v1/tags' do
    it 'creates a first tag unit' do
      post '/api/v1/tags', {
        params: {
          data: {
            id: 'undefined',
            type: 'undefined',
            attributes: {
              title: 'Draft'
            }
          }
        }
      }

      expect(response.status).to eq(200)

      expect(parsed_data['attributes']['title']).to eq('Draft')
      expect(parsed_data['id'].to_i).to be > 0
    end
  end

  describe 'PATCH /api/v1/tags' do
    it 'updates second tag unit' do
      patch '/api/v1/tags/2', {
        params: {
          data: {
            id: '2',
            type: 'tags',
            attributes: {
              title: 'Low Calorie'
            }
          }
        }
      }

      expect(response.status).to eq(200)

      expect(parsed_data['attributes']['title']).to eq('Low Calorie')
      expect(parsed_data['id'].to_i).to eq(2)
    end
  end
end
