# frozen_string_literal: true

FactoryBot.define do
  factory :color_option_type, class: 'Spree::OptionType' do
    name { "color" }
    presentation { "Color" }
  end

  factory :color_option_value_1, class: 'Spree::OptionValue' do
    name { "blue" }
    presentation { "Blue" }
    option_type { :color_option_type }
  end

  factory :color_option_value_2, class: 'Spree::OptionValue' do
    name { "red" }
    presentation { "Red" }
    option_type { :color_option_type }
    surcharge { 3.45 }
  end

  factory :size_option_type, class: 'Spree::OptionType' do
    name { "size" }
    presentation { "Size" }
  end

  factory :size_option_value_1, class: 'Spree::OptionValue' do
    name { "m" }
    presentation { "M" }
    option_type { :size_option_type }
  end

  factory :size_option_value_2, class: 'Spree::OptionValue' do
    name { "xl" }
    presentation { "XL" }
    option_type { :size_option_type }
    surcharge { 2.45 }
  end

  factory :dynamic_variant_product, class: 'Spree::Product' do
    name { "Solidus Shirt" }
    dynamic_variants { true }
    price { 19.99 }
    sku { generate(:sku) }
    available_on { 1.year.ago }
    deleted_at { nil }
    shipping_category { |r| Spree::ShippingCategory.first || r.association(:shipping_category) }

    # ensure stock item will be created for this products master
    before(:create) { create(:stock_location) if Spree::StockLocation.count == 0 }

    tax_category { |r| Spree::TaxCategory.first || r.association(:tax_category) }

    after :create do |product|
      product.master.stock_items.first.adjust_count_on_hand(1000)
    end

    after(:create) do |product|
      product.option_types << [create(:color_option_type), create(:size_option_type)]
    end
  end
end
