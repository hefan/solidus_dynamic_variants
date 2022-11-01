# frozen_string_literal: true

require 'spec_helper'

describe DynamicCartLineItemsController, type: :controller do
  let!(:user) { create(:user) }
  let!(:store) { create(:store) }
  let!(:order) { create(:order) }
  let!(:product) { create(:product) }

  before do
    allow(controller).to receive_messages(try_spree_current_user: user)
  end

  describe '#create' do
    it 'returns 200' do
      post :create, params: { product_id: product.id, quantity: 5 }
      expect(response.response_code).to eq 302
    end
  end
end
