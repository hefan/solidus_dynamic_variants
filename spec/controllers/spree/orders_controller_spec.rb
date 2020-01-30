# frozen_string_literal: true

require 'spec_helper'

describe Spree::OrdersController, type: :controller do
  let!(:user) { create(:user) }
  let!(:product) { create(:product) }

  before do
    allow(controller).to receive_messages(try_spree_current_user: user)
  end

  describe '#variant_populate' do
    it 'returns 200' do
      post :variant_populate, params: { product_id: product.id, quantity: 5 }
      expect(response.response_code).to eq 302
    end
  end
end
