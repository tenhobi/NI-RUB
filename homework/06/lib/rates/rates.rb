# frozen_string_literal: true

require 'csv'
require 'date'
require 'net/http'
require 'fileutils'

require_relative 'conversion'
require_relative 'converter'

module Rates
  # Process rates conversion.
  class Rates
    EXCHANGE_RATE_URI = 'https://www.cnb.cz/cs/financni-trhy/devizovy-trh/kurzy-devizoveho-trhu/kurzy-devizoveho-trhu/denni_kurz.txt'

    def initialize
      @converter = Converter.new
    end

    # Delegates converting of origin currency to target currency.
    #
    # @param [Numeric] amount of money to convert
    # @param [String] from is origin currency code
    # @param [String] to is target currency code
    def convert(amount, from, to)
      puts 'Amount is not a number' unless amount.to_f.is_a? Numeric
      puts 'Origin currency is not a string' unless from.is_a? String
      puts 'Target currency is not a string' unless from.is_a? String

      _update_data unless @converter.data?
      @converter.convert(amount, from, to)
    end

    private

    def _current_day_file_name
      now = DateTime.now
      "#{now.day}.#{now.month}.#{now.year}"
    end

    def _update_data
      @converter.update_data(_get_data)
      @data_present = true
    end

    def _get_data
      dir_path = "#{Dir.home}/.rates"
      file_path = "#{dir_path}/#{_current_day_file_name}.csv"

      if File.file?(file_path)
        file = File.open(file_path, 'r')
        data = file.read
        file.close
        data
      else
        fetched_data = _fetch_data

        begin
          FileUtils.mkdir_p(dir_path) unless File.directory?(dir_path)
          File.open(file_path, 'w') { |f| f.write fetched_data }
        rescue StandardError
          puts 'Cannot save data locally.'
        end

        fetched_data
      end
    end

    def _fetch_data
      url = "#{EXCHANGE_RATE_URI}?date=#{_current_day_file_name}"
      uri = URI(url)
      Net::HTTP.get(uri)
    end
  end
end
