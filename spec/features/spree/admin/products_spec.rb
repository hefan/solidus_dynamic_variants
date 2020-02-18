# frozen_string_literal: true

require 'spec_helper'

describe "Admin Products", type: :feature do
  stub_authorization!

  context "when updating product" do
    let(:product) { create(:product) }

    it "set dynamic variants" do
      visit spree.admin_product_path(product)
      page.check("Dynamic Variants")
      click_button "Update"
      expect(page).to have_content("successfully updated!")
      expect(page.has_checked_field?("product_dynamic_variants")).to be true
      expect(Spree::Product.last.dynamic_variants).to be true
    end
  end
end
