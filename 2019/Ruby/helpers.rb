# frozen_string_literal: true

def paint_grid
  $grid.each_with_index do |row, _y|
    row.each_with_index do |col, _x|
      print col
    end
    puts
  end
end

def traverse_grid
  $grid.each_with_index do |row, y|
    row.each_with_index do |item, x|
      yield y, x, item
    end
  end
end
