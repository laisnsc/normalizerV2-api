require 'rails_helper'

RSpec.describe 'API::V1::OrdersController', type: :request do
  describe 'GET /api/v1/orders' do
    let!(:order1) { create :order, :with_products }
    let!(:order2) { create :order, :with_products }

    context 'when there are orders' do

      it 'returns all orders' do
        get '/api/v1/orders'

        expect(response).to have_http_status(:ok)
        expect(response.body).to include(order1.user.name)
        expect(response.body).to include(order2.user.name)
      end
    end

    context 'when request has additional parameters' do
      it 'recognizes parameters and filters results' do
        get '/api/v1/orders', params: { order_ids: order2.id}
        expect(response).to have_http_status(:ok)
        expect(response.body).not_to include(order1.user.name)
        expect(response.body).to include(order2.user.name)
      end
    end
  end
end
