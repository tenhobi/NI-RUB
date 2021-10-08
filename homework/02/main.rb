require("./calculator")

def test1
  calculator = Calculator.new
  calculator.name = "Smarty"
  puts calculator.name
  puts calculator.result
  calculator.add(5).add(10).add("a").add([2,2,1])
  puts calculator.result
  calculator.div(2).div(0).mult(2, 3, [[[2], 3]]).div([[[5]]]).sub(10, [[5], 1, 2, [[10]]]).reset.add(5)
  puts calculator.result
  puts calculator.add(5).result
end

def test2
  puts Calculator.extreme(:max, 1, 2, 3, [5, [[6], [[[[[3,5,7,5, "a"]]]]]]])
end

def test3
  calc = Calculator.new(10)
  calc.name = "Smarty"
  calc.add 5
  calc.add(1,3,4,5)
  calc.sub 1
  calc.div 3
  puts calc.result

  calc = Calculator.new
  puts calc.add(3).sub(2).mult(8).div(4).result
  calc.name = 'Guy'
  puts calc.name # returns GUY

  puts Calculator.extreme(:max, [3,5,7,5])
  puts Calculator.number? 'foo'
  puts Calculator.number? 5.2
end

test3