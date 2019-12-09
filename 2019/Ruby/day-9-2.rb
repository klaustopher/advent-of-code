require_relative 'int_computer'

code = File.read('day-9.txt').split(",").map(&:to_i)
results = []

icm = IntComputer.new(code, inputs: [2])
icm.run
puts icm.output