#!/usr/bin/env ruby
# frozen_string_literal: true

$data = File.read(ARGV[0]).lines.map(&:chomp)
puts $data.each_cons(2).count { |a, b| a < b }
