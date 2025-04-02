FactoryBot.define do
  factory :product, class: 'Product' do
    name { Faker::Commerce.product_name }
  end
end