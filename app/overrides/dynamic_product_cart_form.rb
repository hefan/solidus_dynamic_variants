Deface::Override.new(
  name: 'dynamic_product_cart_form',
  virtual_path: 'spree/products/show',
  replace_contents: '[data-hook="cart_form"]',
  text: '<% if @product.dynamic_variants? %>
           <%= render :partial => "dynamic_variant_cart_form" %>
         <% else %>
           <%= render :partial => "cart_form" %>
         <% end %>')
