require 'swagger_helper'

RSpec.describe 'api/developers', type: :request do
  path '/developers' do
  

    get 'list of developers' do
      before do
        create(:developer, name: 'Dev_1', age: 26)
        create(:developer, name: 'Dev_2', age: 27)
      end

      tags :developers
      produces 'application/json'
      security [api_key: []]

      response '200', 'OK' do
        schema type: :object,
               properties: {
                 count: { type: :integer },
                 records: { type: :array }
               },
               required: %w[count records]
        let(:Authorization) { '123456' }
        run_test! do |response|
          response_body = JSON.parse(response.body)
          expect(response_body['records'].length).to eq(2)
          expect(response_body['records'].first['name']).to eq('Dev_1')
          expect(response_body['count']).to eq(2)
        end
      end

      response '401', 'Unauthorized' do
        let(:Authorization) { '' }
        run_test!
      end
    end
  end

  path '/developers/{id}' do
    get 'get a developer' do
      tags :developers
      produces 'application/json'
      security [api_key: []]
      parameter name: :id, in: :path, type: :string

      response '200', 'OK' do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 name: { type: :string },
                 age: { type: :integer },
                 created_at: { type: :string },
                 updated_at: { type: :string }
               },
               required: %w[id name age created_at updated_at]

        let(:Authorization) { '123456' }
        let(:id) { create(:developer, name: 'Dev_1', age: 26).id }

        run_test! do |response|
          response_body = JSON.parse(response.body)
          expect(response_body['name']).to eq('Dev_1')
        end
      end

      response '401', 'Unauthorized' do
        let(:Authorization) { '' }
        let(:id) { create(:developer, name: 'Dev_1', age: 26).id }
        run_test!
      end
    end
  end
end
