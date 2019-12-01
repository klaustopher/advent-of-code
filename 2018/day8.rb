#!/usr/bin/env ruby

require 'awesome_print'

class Node
  attr_reader :children, :metadata

  def initialize
    @children = []
    @metadata = []
  end

  def sum
    if children.size == 0
      metadata.inject(:+)
    else
      metadata.map do |child_index|
        children[child_index - 1]&.sum
      end.compact.inject(:+)
    end
  end

  def meta_sum
     metadata.inject(:+).to_i + children.map(&:meta_sum).inject(:+).to_i
  end
end

File.open('day8.txt', 'r') do |f|
  while !f.eof?
    @items = f.readline.split(' ').map(&:strip).map(&:to_i)
  end
end

def read_node
  c_count = @items.shift
  m_count = @items.shift

  puts "Reading #{c_count} children and #{m_count} metadata"

  node = Node.new

  c_count.times do
    node.children << read_node
  end

  m_count.times do
    meta_item = @items.shift
    node.metadata << meta_item
  end

  node
end

root = read_node

puts "Sum of metadata: #{root.meta_sum}"
puts "Sum of Root Node: #{root.sum}"