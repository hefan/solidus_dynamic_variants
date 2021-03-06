# frozen_string_literal: true

require 'spec_helper'

describe "Visiting Products", type: :feature do
  context "when showing product" do
    before do
      create(:store)
    end

    let(:product) { create(:dynamic_variant_product) }

    it "show selectboxes for options" do
      visit spree.product_path(product)
      expect(page).to have_select "options_#{product.option_types.first.id}",
        options: [product.option_types.first.option_values.to_a.first.presentation,
                  product.option_types.first.option_values.to_a.last.presentation]
      expect(page).to have_select "options_#{product.option_types.last.id}",
        options: [product.option_types.last.option_values.to_a.first.presentation,
                  product.option_types.last.option_values.to_a.last.presentation]
    end

    it "add correct dynamic variant to the cart", js: true do
      visit spree.product_path(product)
      click_button "Add To Cart"
      click_link "Home"
      within(".cart-info") do
        expect(page).to have_content("$19.99")
      end
    end

    it "add correct surcharged dynamic variant to the cart", js: true do
      visit spree.product_path(product)
      page.select "Red", from: "options_#{product.option_types.first.id}"
      page.select "XL", from: "options_#{product.option_types.last.id}"
      click_button "Add To Cart"
      click_link "Home"
      within(".cart-info") do
        expect(page).to have_content("$25.89")
      end
    end
  end
end
