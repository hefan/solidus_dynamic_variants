# frozen_string_literal: true

module SolidusDynamicVariants
  module Spree
    module OrdersControllerDecorator
      def variant_populate
        @order = current_order(create_order_if_necessary: true)
        product = ::Spree::Product.find(params[:product_id])
        option_values_ids = params[:options].present? ? params[:options].values : []
        option_values = ::Spree::OptionValue.where(id: option_values_ids)
        variant = product.try_variant option_values
        quantity = params[:quantity].to_i

        # 2,147,483,647 is crazy. See issue #2695.
        if !quantity.between?(1, 2_147_483_647)
          @order.errors.add(:base, Spree.t(:please_enter_reasonable_quantity))
        end

        begin
          @line_item = @order.contents.add(variant, quantity)
        rescue ActiveRecord::RecordInvalid => e
          @order.errors.add(:base, e.record.errors.full_messages.join(", "))
        end

        respond_with(@order) do |format|
          format.html do
            if @order.errors.any?
              flash[:error] = @order.errors.full_messages.join(", ")
              redirect_back_or_default(spree.root_path)
              return
            else
              redirect_to cart_path
            end
          end
        end
      end

      ::Spree::OrdersController.prepend self
    end
  end
end
