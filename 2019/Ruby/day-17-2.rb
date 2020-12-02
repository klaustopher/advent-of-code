# frozen_string_literal: true

require_relative './int_computer'
require_relative './helpers'

input = File.read('day-17.txt').split(',').map(&:to_i)

input[0] = 2

icm = IntComputer.new(input)
