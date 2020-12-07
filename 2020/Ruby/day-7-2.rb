# frozen_string_literal: true

require 'awesome_print'
require 'set'

$input = File.read('day-7.txt').lines.map do |line|
  matches = line.match(/\A(.+) bags contain (.+)\.\Z/)
  parent_bag = matches[1]

  kid_bags = matches[2]
             .split(',')
             .map(&:strip)
             .map do |kids|
    kr = kids.match(/(\d+|no) (.+) bags?/)
    if kr[1] == 'no' && kr[2] == 'other'
      nil
    else
      [kr[2], kr[1].to_i]
    end
  end.compact.to_h

  [parent_bag, kid_bags]
end.to_h

def requirements(search)
  bag_requirements = $input[search]

  return 0 if bag_requirements.count.zero?

  bag_requirements.sum do |bag, count|
    puts "#{search} -> #{bag}: #{count} * #{requirements(bag)}"
    count + count * requirements(bag)
  end
end

puts requirements('shiny gold')
