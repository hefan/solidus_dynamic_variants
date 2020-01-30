# frozen_string_literal: true

require 'spec_helper'

describe Spree::Variant do
  describe "#add_options_and_calc_price" do
    it "has the same price like the master variant if no options given" do
      variant = create(:variant, option_values: [])
      variant.add_options_and_calc_price []

      expect(variant.price).to eq(variant.product.master.price)
    end

    it "has the correct surcharged price" do
      variant = create(:variant, option_values: [])
      ov1 = create(:option_value, surcharge: 10.0)
      ov2 = create(:option_value, surcharge: -5.0)
      variant.add_options_and_calc_price [ov1, ov2]

      expect(variant.price).to eq(variant.product.master.price + 5.0)
    end
  end

  describe "#similar?" do
    it "variants are similar with same option values and price" do
      variant1 = create(:variant, option_values: [])
      variant2 = create(:variant, option_values: [])
      ov1 = create(:option_value, surcharge: 10.0)
      ov2 = create(:option_value, surcharge: 5.0)
      variant1.add_options_and_calc_price [ov1, ov2]
      variant2.add_options_and_calc_price [ov1, ov2]

      expect(variant1.similar?(variant2)).to be true
    end

    it "variants are not similar with other option values" do
      variant1 = create(:variant, option_values: [])
      variant2 = create(:variant, option_values: [])
      ov1 = create(:option_value, surcharge: 10.0)
      ov2 = create(:option_value, surcharge: 5.0)
      ov3 = create(:option_value, surcharge: 20.0)
      variant1.add_options_and_calc_price [ov1, ov2]
      variant2.add_options_and_calc_price [ov1, ov3]

      expect(variant1.similar?(variant2)).to be false
    end

    it "variants are not similar with same option values and other price" do
      variant1 = create(:variant, option_values: [])
      variant2 = create(:variant, option_values: [])
      ov1 = create(:option_value, surcharge: 10.0)
      ov2 = create(:option_value, surcharge: 5.0)
      variant1.add_options_and_calc_price [ov1, ov2]
      ov2.surcharge = 3.0
      variant2.add_options_and_calc_price [ov1, ov2]

      expect(variant1.similar?(variant2)).to be false
    end
  end
end
