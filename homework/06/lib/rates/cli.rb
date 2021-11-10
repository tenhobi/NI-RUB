require 'thor'

require_relative 'version'
require_relative 'rates'

# aaa
module Rates
  class CLI < Thor
    default_task :convert

    map %w[--version -v] => :version
    desc '--version, -v', 'Print the version'

    def version
      puts "Rates #{Rates::VERSION}"
    end

    desc '[amount] [from] [to]', 'Convert amount from origin currency to target currency'
    long_desc 'Supported currency codes (CC): AUD, BRL, BGN, CNY, CZK, DKK, EUR, PHP, HKD, HRK, INR, IDR, ISK, ILS, JPY, ZAR, CAD, KRW, HUF, MYR, MXN, XDR, NOK, NZD, PLN, RON, RUB, SGD, SEK, CHF, THB, USD, GBP.'
    def convert(amount = nil, from = nil, to = nil, *other)
      if amount.nil? || from.nil? || to.nil? || !other.empty?
        puts 'Please, use 3 arguments: ./rates [amount] [from] [to]'
        return
      end

      unless _is_number?(amount)
        puts 'Amount should be a number.'
        return
      end

      unless (from.is_a? Numeric) || (from.length == 3)
        puts 'Origin currency (from) should be a string code with a length of 3.'
        return
      end

      unless (to.is_a? Numeric) || (to.length == 3)
        puts 'Target currency (to) should be a string code with a length of 3.'
        return
      end

      rates = Rates.new
      rates.convert(amount, from.upcase, to.upcase)
    end

    private

    def _is_number?(string)
      true if Float(string)
    rescue StandardError
      false
    end
  end
end
