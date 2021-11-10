# frozen_string_literal: true

require 'test_helper'

require 'minitest/autorun'
require 'rates/converter'
require 'rates/conversion'
require 'csv'

class TestConverter < MiniTest::Test
  def setup
    @converter = Rates::Converter.new
    @known_currencies = %w[ABC DEF GHI]
    @unknown_currencies = %w[XXX YYY AAA ABD]
    data = %(x.y.z #a
      země|měna|množství|kód|kurz
      Aaa|bbb|1|ABC|10,10
      Ccc|ddd|1|DEF|15
      Eee|fff|1|GHI|20.50)
    @converter.update_data(data)
  end

  def test_known_currencies
    @known_currencies.each do |code|
      assert @converter.send(:_known_currency?, code)
    end
  end

  def test_unknown_currencies
    @unknown_currencies.each do |code|
      assert !@converter.send(:_known_currency?, code)
    end
  end

  def test_unknown_convert_from
    @unknown_currencies.each do |code|
      assert_equal 2, @converter.convert(1, code, 'CZK')
    end
  end

  def test_unknown_convert_to
    @unknown_currencies.each do |code|
      assert_equal 3, @converter.convert(1, 'CZK', code)
    end
  end

  def test_from_non_czk
    assert_equal nil, @converter.convert(10, 'ABC', 'CZK')
  end
end
