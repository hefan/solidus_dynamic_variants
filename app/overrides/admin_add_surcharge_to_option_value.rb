Deface::Override.new(
  name: 'admin_option_value_surcharge_header',
  virtual_path: 'spree/admin/option_types/edit',
  insert_before: '[data-hook="option_header"] tr th:last-child',
  text: '<th><%= Spree.t(:surcharge) %></th>')

Deface::Override.new(
  name: 'admin_option_value_surcharge_value',
  virtual_path: 'spree/admin/option_types/_option_value_fields',
  insert_before: '[data-hook="option_value"] td:last-child',
  text:
    '<td class="surcharge">
       <%= f.text_field :surcharge, :value => number_to_currency(f.object.surcharge, :unit => "") %>
     </td>')
