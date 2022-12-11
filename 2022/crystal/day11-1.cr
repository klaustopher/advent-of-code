# Advent of Code 2022 - Day 11
# See https://adventofcode.com/2022/day/11

data = File.read(ARGV[0]).split("\n\n")

class Monkey
  property id : Int32
  property items : Array(Int32)
  property op_op : String
  property op_old : Bool
  property op_v : Int32
  property div : Int32
  property true_monkey : Int32
  property false_monkey : Int32

  def initialize(description : String)
    match = description.match(/Monkey (?<id>\d+):
  Starting items: (?<items>[\d, ]+)
  Operation: new = old (?<op_op>[*+-\/]) (?<op_v>\d+|old)
  Test: divisible by (?<div>\d+)
    If true: throw to monkey (?<true_monkey>\d+)
    If false: throw to monkey (?<false_monkey>\d+)/)

    raise ArgumentError.new("input is wrong") if match.nil?

    @id = match["id"].to_i
    @items = match["items"].split(", ").map { |i| i.to_i }
    @op_op = match["op_op"]
    @op_old = match["op_v"] == "old"
    @op_v = @op_old ? 0 : match["op_v"].to_i
    @div = match["div"].to_i
    @true_monkey = match["true_monkey"].to_i
    @false_monkey = match["false_monkey"].to_i
  end

  def operation(old : Int32) : Int32
    other = op_old ? old : op_v

    case op_op
    when "+" then old + other
    when "-" then old - other
    when "*" then old * other
    when "/" then old // other
    else raise "unknown operation"
    end
  end
end

monkeys = data.map { |monkey_data| Monkey.new(monkey_data) }
inspects = Hash(Int32,Int32).new(0)

20.times do
  monkeys.each do |monkey|
    while !monkey.items.empty?
      inspects[monkey.id] += 1

      item = monkey.items.shift
      new_val = monkey.operation(item) // 3

      if new_val % monkey.div == 0
        monkeys[monkey.true_monkey].items << new_val
      else
        monkeys[monkey.false_monkey].items << new_val
      end
    end
  end
end

puts inspects.values.sort.last(2).product
