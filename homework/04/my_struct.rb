# frozen_string_literal: true

# OpenStruct-like implementation.
class MyStruct
  attr_reader :data

  def initialize(data = nil)
    @data = {}
    _init_from_hash data if data
  end

  def to_h(&block)
    clone = @data.clone
    if block
      clone.to_h(&block)
    else
      clone.to_h
    end
  end

  def [](key)
    @data[key.to_sym]
  end

  def []=(key, value)
    _create_field(key, value)
  end

  def delete_field(key)
    field_name = key.to_sym
    raise NameError, "Cannot delete unknown field '#{field_name}'" unless @data.key?(field_name)

    singleton_class.remove_method(field_name) # getter
    singleton_class.remove_method("#{field_name}=") # setter

    @data.delete(field_name) # data
  end

  def each_pair(&block)
    return @data.to_enum unless block

    @data.each_pair { |key, value| block.call(key, value) }
    self
  end

  def eql?(other)
    other.is_a?(MyStruct) && @data.eql?(other.data)
  end

  def ==(other)
    eql?(other)
  end

  def method_missing(method, *args, &block)
    if method.end_with?('=')
      raise ArgumentError, "wrong number of arguments" if args.size != 1

      field_name = method.to_s.chomp('=')
      _create_field(field_name, args[0])
    # ignore unknown getters
    elsif args.empty?
      nil
    else
      super
    end
  end

  def respond_to_missing?(name, include_private = false)
    true if @data.key?(name)
    super
  end

  private

  def _init_from_hash(data)
    data.each_pair do |key, value|
      _create_field(key, value)
    end
  end

  def _create_field(key, value)
    field_name = key.to_sym

    if _can_create_field?(field_name)
      # getter
      define_singleton_method(field_name) { @data[field_name] }
      # setter
      define_singleton_method("#{field_name}=") { |new_value| @data[field_name] = new_value }
    end

    # assign value
    @data[field_name] = value
  end

  def _can_create_field?(field_name)
    !@data.key?(field_name) && !respond_to?(field_name, true)
  end
end
