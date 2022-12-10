#!/usr/bin/env ruby
# frozen_string_literal: true

data = File.read('3-test.txt').lines.map(&:chomp)

gamma_rate = ''
epsilon_rate = ''

number_of_bits = data.first.length

number_of_bits.times do |i|
  bits_at_position = data.map { |d| d[i] }.tally

  if bits_at_position['1'] > bits_at_position['0']
    gamma_rate += '1'
    epsilon_rate += '0'
  else
    gamma_rate += '0'
    epsilon_rate += '1'
  end
end

puts gamma_rate.to_i(2) * epsilon_rate.to_i(2)
