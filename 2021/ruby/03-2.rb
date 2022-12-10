#!/usr/bin/env ruby
# frozen_string_literal: true

$data = File.read(ARGV[0]).lines.map(&:chomp)
$number_of_bits = $data.first.length

def oxygen_generator_rating
  candidates = $data.dup

  $number_of_bits.times do |i|
    bits_at_position = candidates.map { |d| d[i] }.tally

    if bits_at_position['1'] >= bits_at_position['0']
      candidates.keep_if { |d| d[i] == '1' }
    else
      candidates.keep_if { |d| d[i] == '0' }
    end

    return candidates.first if candidates.count == 1
  end
end

def co2_scrubber_rating
  candidates = $data.dup

  $number_of_bits.times do |i|
    bits_at_position = candidates.map { |d| d[i] }.tally

    if bits_at_position['0'] > bits_at_position['1']
      candidates.keep_if { |d| d[i] == '1' }
    else
      candidates.keep_if { |d| d[i] == '0' }
    end

    return candidates.first if candidates.count == 1
  end
end

puts oxygen_generator_rating.to_i(2) * co2_scrubber_rating.to_i(2)
