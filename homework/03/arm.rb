class Arm
  attr_reader :length, :type

  ALLOWED_TYPES = [:poker, :slasher, :grabber]

  def initialize(length = 1, type = :poker)
    @length = length
    @type = type

    unless @length.is_a? Numeric
      raise 'length is not an number'
    end
    if @length <= 0
      raise 'length should be a positive number'
    end

    unless ALLOWED_TYPES.include? @type
      raise 'wrong arm type'
    end
  end
end
