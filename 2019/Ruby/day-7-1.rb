# frozen_string_literal: true

require_relative 'int_computer'

code = File.read('day-7.txt').split(',').map(&:to_i)
results = []

phase_settings = [0, 1, 2, 3, 4]
phase_settings.permutation.each do |phase_setting|
  last_output = 0

  phase_setting.each do |phase_input|
    icm = IntComputer.new(code, inputs: [phase_input, last_output])
    icm.run
    last_output = icm.output.first
  end

  results << last_output
end

puts results.max
