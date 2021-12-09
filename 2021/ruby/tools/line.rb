# frozen_string_literal: true

class Line
  attr_reader :from, :to, :points

  def initialize(from, to)
    @from = from
    @to = to
    @points = build_points
  end

  private

    def build_points
      if from.x == to.x || from.y == to.y
        build_straight_line
      else
        build_diagonal_line
      end
    end

    def build_straight_line
      x_iterator.map do |x|
        y_iterator.map do |y|
          Point.new(x, y)
        end
      end.flatten
    end

    def build_diagonal_line
      steps = (from.x - to.x).abs

      0.upto(steps).map do
        Point.new(x_iterator.next, y_iterator.next)
      end
    end

    def x_iterator
      @x_iterator ||= if from.x > to.x
                        from.x.downto(to.x)
                      else
                        from.x.upto(to.x)
                      end
    end

    def y_iterator
      @y_iterator ||= if from.y > to.y
                        from.y.downto(to.y)
                      else
                        from.y.upto(to.y)
                      end
    end
end
