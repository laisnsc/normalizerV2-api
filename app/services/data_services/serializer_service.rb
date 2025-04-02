module DataServices
  class SerializerService
    def initialize(order_ids = nil, start_date = nil, end_date = nil)
      @order_ids = order_ids
      @start_date = start_date ? DateTime.parse(start_date) : ''
      @end_date = end_date ? DateTime.parse(end_date) : ''
    end

    def call
      filters = build_data_filters(@order_ids)
      generate_response(filters)
    end

    def build_data_filters(order_ids)
      { order_ids: order_ids }.merge(build_date_range_filter)

    end

    def build_date_range_filter
      return {} unless @start_date.present? && @end_date.present?
      {
        date_range: {
          start_date: @start_date,
          end_date: @end_date
        }
      }
    end

    def generate_response(params)
      users = User.with_orders(params[:order_ids])
      if params[:date_range].present?
        users = users.with_orders_by_date(params[:date_range][:start_date],params[:date_range][:end_date])
      end
      users.map  do |user|
        {
          user_id: user.id,
          name: user.name,
          orders: get_order_data(user.orders.filtered(params[:order_ids]),params[:date_range])
        }
      end
    end

    def get_order_data(orders, dates)
      if dates.present?
        orders = orders.with_date_range(dates[:start_date],dates[:end_date])
      end
      orders.map do |order|
        {
          order_id: order.id,
          total: format("%.2f", order.value_of_all_products),
          date: order.date.strftime("%Y-%m-%d"),
          products: get_order_product_data(order.order_products)
        }
      end
    end

    def get_order_product_data(products)
      products.group_by(&:product_id).map do |prod, val|
        { product_id: prod, value: sprintf("%.2f", val.sum(&:value)) }
      end
    end
  end
end
