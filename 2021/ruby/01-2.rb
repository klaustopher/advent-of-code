#!/usr/bin/env ruby
# frozen_string_literal: true

$data = File.read(ARGV[0]).lines.map(&:chomp)
pp $data.each_cons(3).map(&:sum).each_cons(2).count { |a, b| a < b }
