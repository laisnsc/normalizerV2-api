module Api::V1
  class OrdersController < ApplicationController
    before_action :order_params
    def index
      # orders = Order.all
      orders = DataServices::SerializerService.new(params[:order_ids],
                                                   params[:start_date],
                                                   params[:end_date]).call
      render json: orders
    end

    private

    def order_params
      params.permit(:order_ids, :start_date, :end_date)
    end
  end
end