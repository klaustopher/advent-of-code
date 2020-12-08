# frozen_string_literal: true

require 'awesome_print'

Instruction = Struct.new(:opcode, :value)

code = File.read('day-8.txt').lines.map do |line|
  match = line.match(/\A(\w{3}) (\+|-)(\d+)\Z/)
  Instruction.new(match[1].to_sym, match[2] == '+' ? match[3].to_i : match[3].to_i * -1)
end

instruction_tracker = Hash.new(0)
accumulator = 0
instruction_counter = 0

loop do
  instruction = code[instruction_counter]

  # exit once we are reaching an instruction the 2nd time
  break if (instruction_tracker[instruction_counter]).positive?

  instruction_tracker[instruction_counter] += 1

  case instruction.opcode
  when :acc
    accumulator += instruction.value
    instruction_counter += 1
  when :jmp
    instruction_counter += instruction.value
  when :nop
    instruction_counter += 1
  end
end

puts accumulator
