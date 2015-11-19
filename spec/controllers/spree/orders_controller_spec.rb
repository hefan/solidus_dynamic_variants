require 'spec_helper'

describe Spree::OrdersController, :type => :controller do
  let(:user) { create(:user) }
  let(:order) { Spree::Order.create! }

  context "Order model mock" do

    before do
      allow(controller).to receive_messages(:try_spree_current_user => user)
    end

    describe '#variant_populate' do
      it 'returns 200' do
        spree_post :variant_populate
        expect(response.response_code).to eq 200
      end
    end

  end

end
