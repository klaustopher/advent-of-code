# frozen_string_literal: true

require 'awesome_print'

groups = File
         .read('day-6.txt')
         .split("\n\n")
         .map { |group| group.gsub(/\s/, '').chars }

puts groups.sum { |g| g.uniq.count }
