# frozen_string_literal: true

module SnailfishMath
  def self.parse(array_or_integer)
    if array_or_integer.is_a?(Array)
      Pair.new(parse(array_or_integer.first), parse(array_or_integer.last))
    else
      Value.new(array_or_integer)
    end
  end

  class Value
    attr_accessor :value

    def initialize(value)
      @value = value
    end

    def to_s
      value
    end

    def +(other)
      Pair.new(self, other)
    end

    def add_value(other)
      self.value += other.value
    end

    alias add_value_to_right add_value
    alias add_value_to_left add_value

    def explode(**)
      # cannot explode simple values
      nil
    end

    def magnitude
      value
    end

    def split
      return unless value >= 10

      left = value / 2
      right = value - left

      Pair.new(Value.new(left), Value.new(right))
    end
  end

  class Pair
    attr_accessor :left, :right

    def initialize(left, right)
      @left = left
      @right = right
    end

    def +(other)
      Pair.new(dup, other.dup)
    end

    def to_s
      "[#{left},#{right}]"
    end

    def split
      left_split = left.split

      if left_split
        self.left = left_split
        return self
      end

      right_split = right.split
      if right_split
        self.right = right_split
        return self
      end

      nil
    end

    def magnitude
      (3 * left.magnitude) + (2 * right.magnitude)
    end

    # The requiredment that the number could also go to another pair much earlier in the structure
    # sort of broke my brain ... I had to look at other solutions and discussions to wrap my head
    # around how to solve this ... Not really a brain-child of my own :(
    def explode(level: 0)
      return self if level > 3

      left_explode = left.explode(level: level + 1)
      if left_explode
        right.add_value_to_left(left_explode.right)
        self.left = Value.new(0) if level == 3

        return Pair.new(left_explode.left, Value.new(0))
      end

      right_explode = right.explode(level: level + 1)
      if right_explode
        left.add_value_to_right(right_explode.left)
        self.right = Value.new(0) if level == 3
        return Pair.new(Value.new(0), right_explode.right)
      end

      nil
    end

    def reduce
      loop do
        # puts self
        next if explode(level: 0)
        next if split

        break
      end

      self
    end

    def add_value_to_right(value)
      right.add_value_to_right(value)
    end

    def add_value_to_left(value)
      left.add_value_to_left(value)
    end
  end
end
