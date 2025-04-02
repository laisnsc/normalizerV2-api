FactoryBot.define do
  factory :order do
    date { Faker::Date.in_date_period }

    association :user, factory: :user

    trait :with_products do
      after(:create) do |order|
        create_list(:order_product, 2, order: order)
      end
    end
  end
end