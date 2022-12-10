# frozen_string_literal: true

require_relative 'int_computer'

code = File.read('day-7.txt').split(',').map(&:to_i)
results = []

phase_settings = [5, 6, 7, 8, 9]

amplifiers = [
  IntComputer.new(code),
  IntComputer.new(code),
  IntComputer.new(code),
  IntComputer.new(code),
  IntComputer.new(code)
]

phase_settings.permutation.each do |phase_setting|
  amplifiers = [
    IntComputer.new(code, name: 'A', inputs: [phase_setting[0], 0]),
    IntComputer.new(code, name: 'B', inputs: [phase_setting[1]]),
    IntComputer.new(code, name: 'C', inputs: [phase_setting[2]]),
    IntComputer.new(code, name: 'D', inputs: [phase_setting[3]]),
    IntComputer.new(code, name: 'E', inputs: [phase_setting[4]])
  ]

  amplifiers.each(&:run)

  until amplifiers.all?(&:ended)
    padded_amps = [amplifiers[4]] + amplifiers + [amplifiers[0]]
    padded_amps.each_cons(2) do |amp_a, amp_b|
      if amp_b.waiting && amp_a.output.length.positive?
        amp_b.inputs << amp_a.output.shift
        amp_b.run
      end
    end
  end

  results << amplifiers.last.output.last
end

puts results.max
