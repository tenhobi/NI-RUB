# frozen_string_literal: true

module Rates
  # Converter of currency to currency using data that is passed as CSV.
  class Converter
    def initialize
      @data = {}
      @data_present = false
    end

    # Converts amount of origin currency to target currency.
    # Expects that data is set using update_data method.
    #
    # @param [Numeric] amount of money to convert
    # @param [String] from is origin currency code
    # @param [String] to is target currency code
    def convert(amount, from, to)
      origin_amount = amount

      unless data?
        puts 'Error: invalid usage, converter has no data.'
        return 1
      end
      unless _known_currency? from
        puts "Unknown source currency #{from}"
        return 2
      end
      unless _known_currency? to
        puts "Unknown target currency #{to}"
        return 3
      end

      if from != 'CZK'
        tmp_conversion = @data[from]
        amount = amount.to_f * (tmp_conversion.ratio / tmp_conversion.amount)
      end

      conversion = @data[to]
      converted_money = amount.to_f / (conversion.ratio / conversion.amount)
      puts "#{origin_amount.to_f.round(3)} of #{from} is #{converted_money.round(3)} in #{to}"
    end

    # Updates internal data.
    #
    # @param [String] data in CSV format containing currency exchange rate.
    def update_data(data)
      csv = CSV.new(data, col_sep: '|')

      csv.drop(2).each do |row|
        amount = (row[2].sub ',', '.').to_f
        code = row[3]
        ratio = (row[4].sub ',', '.').to_f

        @data[code] = Conversion.new(amount, code, ratio)
      end

      @data['CZK'] = Conversion.new(1, 'CZK', 1)

      @data_present = true
    end

    # @return [Boolean] determines if the exchange data is present.
    def data?
      @data_present
    end

    private

    def _known_currency?(currency)
      (currency == 'CZK') || @data.key?(currency)
    end
  end
end