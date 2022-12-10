# frozen_string_literal: true

require_relative 'int_computer'

code = File.read('day-2.txt').split(',').map(&:to_i)

code[1] = 12
code[2] = 2

icm = IntComputer.new(code)
icm.run

puts icm.read(0)
