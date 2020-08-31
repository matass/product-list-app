# frozen_string_literal: true

RSpec.describe API::V1::ProductsController, type: :request do
  describe 'POST /api/v1/products' do
    it 'creates a first product unit' do
      post '/api/v1/products', {
        params: {
          data: {
            id: 'undefined',
            type: 'undefined',
            attributes: {
              name: 'Coke',
              description: '24oz Bottle',
              price: '1.98'
            }
          }
        }, headers: headers
      }

      expect(response.status).to eq(200)

      expect(parsed_data['attributes']['name']).to eq('Coke')
      expect(parsed_data['attributes']['description']).to eq('24oz Bottle')
      expect(parsed_data['attributes']['price']).to eq('1.98')
      expect(parsed_data['id'].to_i).to be > 0
    end

    it 'creates a second product unit' do
      post '/api/v1/products', {
        params: {
          data: {
            id: 'undefined',
            type: 'undefined',
            attributes: {
              name: 'Pepsi',
              description: '24oz Bottle',
              price: '1.98'
            }
          }
        }
      }

      expect(response.status).to eq(200)

      expect(parsed_data['attributes']['name']).to eq('Pepsi')
      expect(parsed_data['attributes']['description']).to eq('24oz Bottle')
      expect(parsed_data['attributes']['price']).to eq('1.98')
      expect(parsed_data['id'].to_i).to be > 0
    end
  end

  describe 'GET /api/v1/products' do
    it 'gets products' do
      get '/api/v1/products'

      expect(response.status).to eq(200)

      expect(JSON.parse(response.body)['data'][0]['attributes']['name']).to eq('Coke')
    end
  end

  describe 'PATCH /api/v1/products/*' do
    it 'updates second product name' do
      patch '/api/v1/products/2', {
        params: {
          data: {
            id: '2',
            type: 'procuts',

            attributes: {
              name: 'Pepsi Lemon'
            }
          }
        }
      }

      expect(response.status).to eq(200)

      expect(parsed_data['attributes']['name']).to eq('Pepsi Lemon')
      expect(parsed_data['id'].to_i).to eq(2)
    end

    it 'updates first product with tags' do
      patch '/api/v1/products/1', {
        params: {
          data: {
            id: '1',
            type: 'procuts',

            attributes: {
              name: 'Coke Diet',
              tags: ['Beverage', 'Calorie Free']
            }
          }
        }
      }

      expect(response.status).to eq(200)

      expect(parsed_data['attributes']['name']).to eq('Coke Diet')
      expect(parsed_data['relationships']['tags']['data'][0]['id']).to eq('1')
      expect(parsed_data['relationships']['tags']['data'][1]['id']).to eq('2')
    end

    it 'updates second product name with tags' do
      patch '/api/v1/products/2', {
        params: {
          data: {
            id: '2',
            type: 'products',

            attributes: {
              name: 'Pepsi Zero',
              tags: ['Calorie Free']
            }
          }
        }
      }

      expect(response.status).to eq(200)

      expect(parsed_data['attributes']['name']).to eq('Pepsi Zero')
      expect(parsed_data['id']).to eq('2')
      expect(parsed_data['relationships']['tags']['data'][0]['id']).to eq('2')
    end
  end
end
