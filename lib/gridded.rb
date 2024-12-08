# frozen_string_literal: true

module Gridded
  def min_x = 0
  def min_y = 0
  def max_x = lines[0].size - 1
  def max_y = lines.size - 1

  def each_point
    lines.each_with_index do |line, y|
      line.each_char.with_index do |value, x|
        yield [x, y], value
      end
    end
  end

  def on_grid?((x, y))
    x >= min_x && x <= max_x &&
      y >= min_y && y <= max_y
  end

  def off_grid?(...)
    !on_grid?(...)
  end

  def grid_value_at((x, y))
    lines[y]&.send(:[], x)
  end
end
