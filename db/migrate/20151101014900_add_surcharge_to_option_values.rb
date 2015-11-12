class AddSurchargeToOptionValues < ActiveRecord::Migration

  def change
    add_column :spree_option_values, :surcharge, :decimal, :precision => 8, :scale => 2, :default => 0.0
  end

end
