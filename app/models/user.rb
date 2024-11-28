class User < ApplicationRecord
  has_many :orders

  validates :name, presence: true

  scope :with_orders, ->(order_ids) { joins(:orders).merge(Order.filtered(order_ids)).distinct }

  scope :with_orders_by_date, ->(from, to) do
    from.present? && to.present? ? joins(:orders).where(orders: {date: from..to }).distinct : all
  end
end

