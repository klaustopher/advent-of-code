
input = File.read('day-2.txt').split(',').map(&:to_i)

def compute(ram, noun, verb)
  pointer = 0

  ram[1] = noun
  ram[2] = verb

  loop do
    if ram[pointer] == 1
      ram[ram[pointer + 3]] = ram[ram[pointer + 1]] + ram[ram[pointer + 2]]
      pointer += 4
    elsif ram[pointer] == 2
      ram[ram[pointer + 3]] = ram[ram[pointer + 1]] * ram[ram[pointer + 2]]
      pointer += 4
    elsif ram[pointer] == 99
      break
    end
  end

  ram[0]
end

0.upto(99).each do |noun|
  0.upto(99).each do |verb|
    puts noun*100+verb if compute(input.dup, noun, verb) == 19690720
  end
end

