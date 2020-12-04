# frozen_string_literal: true

require 'awesome_print'

data = File
       .read('day-4.txt')
       .split("\n\n")
       .map { |l| l.split(/\s+/).map { |x| x.split(':') }.to_h }

$mandatory_fields = %w[byr iyr eyr hgt hcl ecl pid]
$optional_fields = %w[cid]

valid_passports = 0

data.each do |pp_data|
  valid_passports += 1 if $mandatory_fields.all? { |field| pp_data.keys.include?(field) }
end

puts valid_passports
