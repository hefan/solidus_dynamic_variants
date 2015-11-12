Deface::Override.new(
  name: 'admin_product_dynamic_variants',
  virtual_path: 'spree/admin/products/_form',
  insert_after: '[data-hook="admin_product_form_promotionable"]',
  text:
     '<div data-hook="admin_product_form_dynamic_variants">
        <%= f.field_container :dynamic_variants do %>
          <%= f.label :dynamic_variants do %>
            <%= f.check_box :dynamic_variants %> <%= Spree.t(:dynamic_variants) %>
          <% end %>
        <% end %>
      </div>')
