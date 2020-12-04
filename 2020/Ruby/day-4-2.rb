# frozen_string_literal: true

require 'awesome_print'

data = File
       .read('day-4.txt')
       .split("\n\n")
       .map { |l| l.split(/\s+/).map { |x| x.split(':') }.to_h }

$mandatory_fields = %w[byr iyr eyr hgt hcl ecl pid]
$optional_fields = %w[cid]

def valid_passport?(pp_data)
  return false unless $mandatory_fields.all? { |field| pp_data.keys.include?(field) }
  return false if pp_data['byr'].to_i < 1920 || pp_data['byr'].to_i > 2002
  return false if pp_data['iyr'].to_i < 2010 || pp_data['iyr'].to_i > 2020
  return false if pp_data['eyr'].to_i < 2020 || pp_data['eyr'].to_i > 2030

  if pp_data['hgt'].end_with?('cm')
    return false if pp_data['hgt'].to_i < 150 || pp_data['hgt'].to_i > 193
  elsif pp_data['hgt'].end_with?('in')
    return false if pp_data['hgt'].to_i < 59 || pp_data['hgt'].to_i > 76
  else
    return false
  end

  return false unless pp_data['hcl'] =~ /\A#[a-f0-9]{6}\Z/
  return false unless %w[amb blu brn gry grn hzl oth].include?(pp_data['ecl'])
  return false unless pp_data['pid'] =~ /\A[0-9]{9}\Z/

  true
end

valid_passports = 0

data.each do |pp_data|
  valid_passports += 1 if valid_passport?(pp_data)
end

puts valid_passports
