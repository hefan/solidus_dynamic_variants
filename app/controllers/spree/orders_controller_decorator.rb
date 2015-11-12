Spree::OrdersController.class_eval do

  def variant_populate
    order = current_order(create_order_if_necessary: true)
    product = Spree::Product.find(params[:product_id])
    option_values = Spree::OptionValue.where(id: params[:options].values)
    variant = product.try_variant option_values
    quantity = params[:quantity].to_i

    # 2,147,483,647 is crazy. See issue #2695.
    if quantity.between?(1, 2_147_483_647)
      begin
        order.contents.add(variant, quantity)
      rescue ActiveRecord::RecordInvalid => e
        error = e.record.errors.full_messages.join(", ")
      end
    else
      error = Spree.t(:please_enter_reasonable_quantity)
    end

    if error
      flash[:error] = error
      redirect_back_or_default(spree.root_path)
    else
      respond_with(order) do |format|
        format.html { redirect_to cart_path }
      end
    end

  end

end
