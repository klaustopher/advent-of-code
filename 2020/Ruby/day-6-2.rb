# frozen_string_literal: true

require 'awesome_print'

groups = File
         .read('day-6.txt')
         .split("\n\n")
         .map { |group| group.split("\n").map(&:chars) }

all_correct = 0
groups.each do |group|
  ('a'..'z').each do |question|
    all_correct += 1 if group.all? { |person| person.include?(question) }
  end
end

puts all_correct
