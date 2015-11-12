class AddDynamicVariantsToProducts < ActiveRecord::Migration

  def change
    add_column :spree_products, :dynamic_variants, :boolean, :default => false
  end

end
