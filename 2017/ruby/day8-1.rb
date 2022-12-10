instructions = File.read('day8.txt').lines.map(&:chomp).map { |line| line.split(/\s+/) }

registers = Hash.new(0)

instructions.each do |(register, operation, value, _if, if_register, if_condition, if_value)|
  case if_condition
  when ">"
    next unless registers[if_register] > if_value.to_i
  when "<"
    next unless registers[if_register] < if_value.to_i
  when ">="
    next unless registers[if_register] >= if_value.to_i
  when "<="
    next unless registers[if_register] <= if_value.to_i
  when "=="
    next unless registers[if_register] == if_value.to_i
  when "!="
    next unless registers[if_register] != if_value.to_i
  end

  case operation
  when "inc" then registers[register] += value.to_i
  when "dec" then registers[register] -= value.to_i
  end
end

pp registers.values.max
