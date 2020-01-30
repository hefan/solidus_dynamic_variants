class AddDynamicVariantsToProducts < ActiveRecord::Migration[4.2]

  def change
    add_column :spree_products, :dynamic_variants, :boolean, :default => false
  end

end
