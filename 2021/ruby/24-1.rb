#!/usr/bin/env ruby
# frozen_string_literal: true

# Advent of Code 2021 - Day 24

require_relative './tools/alu'

$data = File.read(ARGV[0]).lines.map(&:chomp).map(&:split)

alu = ALU.new($data)

99999999999999.downto(11111111111111) do |nr|
  next if nr.to_s =~ /0/
  print "#{nr} \r"
  if alu.run(nr.to_s)['z'] == 0
    puts "Winner: #{nr}"
    break
  end
end


