#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative './tools/bits_parser'

inputs = File.read(ARGV[0]).lines.map(&:chomp)

inputs.each do |input|
  parser = BITSParser.new(input)
  parser.parse
  puts parser.results.sum(&:version_sum)
end
