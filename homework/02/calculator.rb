class Calculator
  def initialize(state = 0, name = "Calculator")
    @initial_state = state
    @state = @initial_state
    @name = name
  end

  def name
    @name.upcase
  end

  def name=(value)
    @name = value
  end

  def add(*params)
    params.each do |value|
      _add_to_state(value)
    end
    self
  end

  def sub(*params)
    params.each do |value|
      _sub_from_state(value)
    end
    self
  end

  def mult(*params)
    params.each do |value|
      _mult_state(value)
    end
    self
  end

  def div(*params)
    params.each do |value|
      _div_state(value)
    end
    self
  end

  def result
    @state
  end

  def reset
    @state = @initial_state
    self
  end

  # první parametr je symbol. Buď :max nebo :min.
  # V případě chyby je možno použít fail, raise, nepo pouze obyčejnou hlášku.
  # druhý parametr je pole čísel
  # cíl je jednoduchý: metoda vrátí extrém v poli podle prvního parametru.
  # ---
  # U metody extreme si normálně můžete vybrat, zda bude brát právě 2 parametry (tedy :min/:max + array), nebo 2+ (:min/:max + další parametry). Za +0.5b to zvládne přijmout obojí . Tedy jak extreme(:min, [1, 2, 3, 4]), tak extreme(:min, 1, 2, 3, 4) .
  def self.extreme(method, *params)
    if method != :min and method != :max
      raise "Wrong method, use :min or :max."
    end

    values = params.flatten
    current_value = values.first

    values.each do |value|
      unless Calculator.number?(value)
        next
      end

      if method == :min
        current_value = value if current_value > value
      elsif method == :max
        current_value = value if current_value < value
      end
    end

    current_value
  end

  def self.number?(value)
    value.is_a? Numeric
  end

  private

  def _add_to_state(value)
    if value.is_a? Array
      value.flatten.each do |arr_value|
        _add_to_state(arr_value)
      end
    elsif Calculator.number?(value)
      @state += value
    end
  end

  def _sub_from_state(value)
    if value.is_a? Array
      value.flatten.each do |arr_value|
        _sub_from_state(arr_value)
      end
    elsif Calculator.number?(value)
      @state -= value
    end
  end

  def _mult_state(value)
    if value.is_a? Array
      value.flatten.each do |arr_value|
        _mult_state(arr_value)
      end
    elsif Calculator.number?(value)
      @state *= value
    end
  end

  def _div_state(value)
    if value.is_a? Array
      value.flatten.each do |arr_value|
        _div_state(arr_value)
      end
    elsif Calculator.number?(value)
      puts "Warning: Cannot divide by zero. Division ignored." if value == 0
      @state /= value if value != 0
    end
  end

end
