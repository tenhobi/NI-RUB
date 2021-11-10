# frozen_string_literal: true

module Rates
  # Helper data class that stores exchange conversion data.
  class Conversion
    attr_reader :amount, :code, :ratio

    # Tl;dr amount of in currency-code is ratio in CZK
    #
    # @param [Numeric] amount of money to convert from target currency
    # @param [String] code of target currency
    # @param [Numeric] ratio of money equivalent in CZK
    def initialize(amount, code, ratio)
      @amount = amount
      @code = code
      @ratio = ratio
    end
  end
end
