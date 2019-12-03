require_relative 'int_computer'

input = File.read('day-2.txt').split(',').map(&:to_i)

def compute(code, noun, verb)
  code[1] = noun
  code[2] = verb
  icm = IntComputer.new(code)
  icm.run
  icm.read(0)
end

0.upto(99).each do |noun|
  0.upto(99).each do |verb|
    puts noun*100+verb if compute(input.dup, noun, verb) == 19690720
  end
end

