class ScannerImage
  def initialize(algorithm, pass=0)
    # When the 0 index element of the algorithm is true, we need to
    # flip what the unknown input is, otherwise we would be starting
    # to put a rim around the image and would add unneeded lit pixels
    hash_default_value = if algorithm[0]
                           pass % 2 == 1
                         else
                           false
                         end

    @image = Hash.new(hash_default_value)
    @min_x = 0
    @min_y = 0
    @max_x = 0
    @max_y = 0
    @pass = pass
    @algorithm = algorithm
  end

  def mark_pixel(point, light_up)
    @max_x = [@max_x, point.x].max
    @max_y = [@max_y, point.y].max

    @min_x = [@min_x, point.x].min
    @min_y = [@min_y, point.y].min

    @image[point] = light_up
  end

  def print_image
    start_x = @min_x - 3
    end_x = @max_x + 3

    start_y = @min_y - 3
    end_y = @max_y + 3

    start_x.upto(end_x) do |x|
      start_y.upto(end_y) do |y|
        print @image[Point.new(x,y)] ? '#' : '.'
      end
      puts
    end
  end

  def apply_algorithm
    new_image = ScannerImage.new(@algorithm, @pass + 1)
    start_x = @min_x - 1
    end_x = @max_x + 1

    start_y = @min_y - 1
    end_y = @max_y + 1

    start_x.upto(end_x) do |x|
      start_y.upto(end_y) do |y|
        point = Point.new(x, y)
        algo_pos = determine_algo_index(point)
        new_image.mark_pixel(point, @algorithm[algo_pos])
      end
    end

    new_image
  end

  def determine_algo_index(point)
    considered_points = [
      Point.new(point.x - 1, point.y - 1),
      Point.new(point.x - 1, point.y),
      Point.new(point.x - 1, point.y + 1),

      Point.new(point.x,     point.y - 1),
      Point.new(point.x,     point.y),
      Point.new(point.x,     point.y + 1),

      Point.new(point.x + 1, point.y - 1),
      Point.new(point.x + 1, point.y),
      Point.new(point.x + 1, point.y + 1)
    ]

    considered_points.map { |point| @image[point] ? '1' : '0' }.join.to_i(2)
  end

  def lit_pixel_count
    @image.values.count(&:itself)
  end
end
