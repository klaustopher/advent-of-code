# frozen_string_literal: true

require_relative 'int_computer'

code = File.read('day-5.txt').split(',').map(&:to_i)

inputs = [5]

icm = IntComputer.new(code, inputs: inputs)
icm.run

puts icm.output
