require 'spec_helper'

describe Spree::Product do
  describe "#try_variant" do
    it "gets a new variant" do
      product = create(:product)
      ov1 = create(:option_value, :surcharge => 10.0)
      ov2 = create(:option_value, :surcharge => 20.0)
      product.option_types << [ov1.option_type, ov2.option_type]
      variant = product.try_variant [ov1, ov2]

      expect(variant).not_to be_nil
      expect(variant.is_master).to be false
    end

    it "returns an already created similar variant" do
      product = create(:product)
      ov1 = create(:option_value, :surcharge => 10.0)
      ov2 = create(:option_value, :surcharge => 20.0)
      product.option_types << [ov1.option_type, ov2.option_type]
      variant1 = product.try_variant [ov1, ov2]
      variant2 = product.try_variant [ov1, ov2]

      expect(variant1).to eq(variant2)
    end

    it "gets nonsimilar new variant after option value surcharge update" do
      product = create(:product)
      ov1 = create(:option_value, :surcharge => 10.0)
      ov2 = create(:option_value, :surcharge => 20.0)
      product.option_types << [ov1.option_type, ov2.option_type]
      variant1 = product.try_variant [ov1, ov2]
      ov1.surcharge = 11.0
      variant2 = product.try_variant [ov1, ov2]

      expect(variant1).not_to eq(variant2)
    end

    it "gets the master variant if no options given" do
      product = create(:product)
      variant = product.try_variant []

      expect(variant).to eq(product.master)
    end

  end
end
