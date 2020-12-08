# frozen_string_literal: true

require 'awesome_print'

Instruction = Struct.new(:opcode, :value)

code = File.read('day-8.txt').lines.map do |line|
  match = line.match(/\A(\w{3}) (\+|-)(\d+)\Z/)
  Instruction.new(match[1].to_sym, match[2] == '+' ? match[3].to_i : match[3].to_i * -1)
end

def run_code(code)
  accumulator = 0
  instruction_counter = 0

  loop do
    return accumulator if instruction_counter >= code.size

    instruction = code[instruction_counter]

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
end

def code_works?(code)
  instruction_tracker = Hash.new(0)
  accumulator = 0
  instruction_counter = 0

  loop do
    return true if instruction_counter >= code.size

    instruction = code[instruction_counter]

    # exit once we are reaching an instruction the 2nd time
    return false if instruction_tracker[instruction_counter].positive?

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
end

0.upto(code.length - 1) do |idx|
  test_code = code.map(&:dup)

  case test_code[idx].opcode
  when :nop
    test_code[idx].opcode = :jmp
  when :jmp
    test_code[idx].opcode = :nop
  else
    next
  end

  puts run_code(test_code) if code_works?(test_code)
end
