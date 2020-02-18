# frozen_string_literal: true

require 'spec_helper'

RSpec.feature "Admin Option Types", js: true do
  stub_authorization!

  before(:each) do
    visit spree.admin_path
    click_link "Products"
  end

  context "update option types" do
    let(:option_type) { create(:option_type) }

    it 'should set surcharge' do
      visit spree.edit_admin_option_type_path(option_type)

      fill_in "option_type_option_values_attributes_0_name", with: "xl"
      fill_in "option_type_option_values_attributes_0_presentation", with: "XL"
      fill_in "option_type_option_values_attributes_0_surcharge", with: "3.95"
      click_button "Update"
      expect(page).to have_content("successfully updated!")
      expect(page).to have_field('option_type_option_values_attributes_0_surcharge', with: '3.95')
      expect(Spree::OptionType.last.option_values.first.surcharge).to eq(0.395e1)
    end

  end

end
