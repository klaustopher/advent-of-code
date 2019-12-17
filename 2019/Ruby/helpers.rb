def paint_grid
  $grid.each_with_index do |row, y|
    row.each_with_index  do |col, x|
      print col
    end
    puts
  end
end

def traverse_grid
  $grid.each_with_index do |row, y|
    row.each_with_index  do |item, x|
      yield y, x, item
    end
  end
end
