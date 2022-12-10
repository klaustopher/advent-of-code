# frozen_string_literal: true

require 'awesome_print'

adapters = File.read('day-10.txt').lines.map(&:to_i).sort

builtin = adapters.max + 3

array = [0] + adapters + [builtin]

counter = Hash.new(0)

array.each_cons(2) do |a, b|
  counter[b - a] += 1
end

puts counter[1] * counter[3]
