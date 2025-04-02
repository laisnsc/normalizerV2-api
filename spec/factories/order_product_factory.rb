FactoryBot.define do
  factory :order_product, class: OrderProduct do
    sequence(:value) { Faker::Commerce.price }

    association :order, factory: :order
    association :product, factory: :product
  end
end