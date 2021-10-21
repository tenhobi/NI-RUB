class MyStruct
  def method_missing(method, *args, &block)
    if method.end_with?('[]')
      field_name = args[0]
      send field_name
    elsif method.end_with?('[]=')
      field_name = args[0]
      send "#{field_name}=", args[1]
    elsif method.end_with?('=')
      field_name = method.to_s.chomp('=')
      puts "creating field '#{field_name}'"

      # getter
      define_singleton_method field_name do
        instance_variable_get("@#{field_name}")
      end

      # setter
      define_singleton_method "#{field_name}=" do |value|
        instance_variable_set("@#{field_name}", value)
      end

      send "#{field_name}=", args
    else
      super
    end
  end

  def respond_to_missing?
    # TODO
  end

  def delete_field(field)
    remove_instance_variable("@#{field}")
    instance_eval "undef #{field}"
    instance_eval "undef #{field}="
  end

  def each_pair
    (methods false).map { |method|
      next if method.end_with?('=')

      value = send method
      ["#{method}".to_sym, value[0]]
    }.compact.to_enum
  end
end
