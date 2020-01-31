# frozen_string_literal: true

module SolidusDynamicVariants
  module Spree
    module VariantDecorator
      def add_options_and_calc_price(new_option_values)
        self.price = product.price
        new_option_values.each do |ov|
          option_values << ov
          self.price += ov.surcharge if ov.surcharge.present?
        end
      end

      def similar?(other)
        return false if equal? other # equal is not similar

        ( other.option_values.map(&:id).eql? option_values.map(&:id) ) &&
               (other.price.eql? self.price)
      end

      ::Spree::Variant.prepend self
    end
  end
end
