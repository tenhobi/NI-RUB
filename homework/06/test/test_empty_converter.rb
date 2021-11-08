# frozen_string_literal: true

require 'test_helper'

require 'minitest/autorun'
require 'rates/converter'

class TestEmptyConverter < MiniTest::Test
  def setup
    @converter = Rates::Converter.new
  end

  def test_error_without_data
    assert_equal 1, @converter.convert(1, 'a', 'a')
  end

  def test_update_data
    assert !@converter.data?
    data = %(x.y.z #a
      země|měna|množství|kód|kurz
      Aaa|bbb|1|ABC|10,10
      Ccc|ddd|1|DEF|15
      Eee|fff|1|GHI|20.50)
    @converter.update_data(data)
    assert @converter.data?
  end
end
