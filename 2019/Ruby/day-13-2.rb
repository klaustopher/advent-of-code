require_relative './int_computer'

input = File.read('day-13.txt').split(',').map(&:to_i)

# Put some quarters in the machine
input[0] = 2

$grid = Array.new(42) { Array.new(20, ' ') }
$score = 0
$paddle_x = 0
$ball_x = 0

def print_grid
  system('clear')

  puts "Score: #{$score}", "", ""
  $grid.each do |row|
    row.each do |c|
      print c
    end
    puts
  end
end

icm = IntComputer.new(input)
while(!icm.ended) do
  icm.run

  count = 0

  icm.output.each_slice(3) do |x, y, tile_id|
    $grid[y][x] = case tile_id
    when 0 then ' '
    when 1 then 'W'
    when 2 then 'B'
    when 3 then '-'
    when 4 then '*'
    end

    $paddle_x = x if tile_id == 3
    $ball_x = x if tile_id == 4
    $score = tile_id if x == -1 && y == 0
  end

  icm.output.clear

  if $paddle_x < $ball_x
    icm.inputs << 1
  elsif $paddle_x > $ball_x
    icm.inputs << -1
  else
    icm.inputs << 0
  end

  # print_grid
end

puts $score