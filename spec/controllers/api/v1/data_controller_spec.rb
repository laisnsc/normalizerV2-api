require 'rails_helper'

RSpec.describe 'API::V1::DataController', type: :request do
  let(:path) { Rails.root.join('spec', 'fixtures', 'examples', 'data_test.txt') }
  let(:file) { fixture_file_upload(path, 'text/plain') }
  describe 'POST #process_data' do
    context 'when successful' do
      it 'returns success' do
        post '/api/v1/data/process_data', params: { file: file }
        json_response = JSON.parse(response.body)

        expect(response).to have_http_status(:ok)
        expect(response.content_type).to include('application/json')
        expect(json_response["message"]).to include("File processed successfully")
      end
    end
    context 'when file is not sent' do
      it 'returns error status' do
        post '/api/v1/data/process_data'
        json_response = JSON.parse(response.body)

        expect(response).to have_http_status(:unprocessable_entity)
        expect(json_response["error"]).to eq("File not found")
      end
    end
  end
end
