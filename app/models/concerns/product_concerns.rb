# frozen_string_literal: true

module ProductConcerns
  extend ActiveSupport::Concern

  def try_variant(option_values)
    return master if option_values.blank?

    new_variant = Spree::Variant.new(product: self,
                                     sku: "#{sku}-#{(Time.now.to_f * 1000.0).to_i}",
                                     track_inventory: false)
    new_variant.add_options_and_calc_price option_values
    get_or_save_variant new_variant
  end

  private

  def get_or_save_variant(new_variant)
    aspirants = Spree::Variant.includes(:option_values).where(is_master: false,
                                                              product: self,
                                                              deleted_at: nil)
    similar = aspirants.detect { |av| new_variant.similar? av }
    return similar if similar.present?

    new_variant.save!
    new_variant
  end
end
