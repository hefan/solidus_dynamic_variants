Spree::Product.class_eval do

  def try_variant(option_values)
    return master if options.blank?
    new_variant = Spree::Variant.new(product: self,
                                     sku: "-#{(Time.now.to_f * 1000.0).to_i}",
                                     track_inventory: false)
    new_variant.add_options_and_calc_price option_values
    return get_or_save_variant new_variant
  end


  private

  def get_or_save_variant(new_variant)
    aspirants = Spree::Variant.includes(:option_values).where(is_master: false,
                                                              product: self,
                                                              deleted_at: nil)
    similar = aspirants.detect { |av| new_variant.similar? av }
    return similar if similar.present?

    new_variant.save!
    return new_variant
  end

end
