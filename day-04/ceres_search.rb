# frozen_string_literal: true

class CeresSearch
  include NewlineInput

  XMAS = "XMAS"

  def xmas_count
    min_x = 0 + XMAS.size - 1
    min_y = 0 + XMAS.size - 1
    max_x = lines[0].size - XMAS.size
    max_y = lines.size - XMAS.size
    words = []

    lines.each_with_index do |line, y|
      line.each_char.with_index do |_char, x|
        words << (lines[y][x] + lines[y][x + 1] + lines[y][x + 2] + lines[y][x + 3]) if x <= max_x

        if x <= max_x && y <= max_y
          words << (lines[y][x] + lines[y + 1][x + 1] + lines[y + 2][x + 2] + lines[y + 3][x + 3])
        end

        words << (lines[y][x] + lines[y + 1][x] + lines[y + 2][x] + lines[y + 3][x]) if y <= max_y

        if x >= min_x && y <= max_y
          words << (lines[y][x] + lines[y + 1][x - 1] + lines[y + 2][x - 2] + lines[y + 3][x - 3])
        end

        words << (lines[y][x] + lines[y][x - 1] + lines[y][x - 2] + lines[y][x - 3]) if x >= min_x

        if x >= min_x && y >= min_y
          words << (lines[y][x] + lines[y - 1][x - 1] + lines[y - 2][x - 2] + lines[y - 3][x - 3])
        end

        words << (lines[y][x] + lines[y - 1][x] + lines[y - 2][x] + lines[y - 3][x]) if y >= min_y

        if y >= min_y && x <= max_x
          words << (lines[y][x] + lines[y - 1][x + 1] + lines[y - 2][x + 2] + lines[y - 3][x + 3])
        end
      end
    end

    words.count(XMAS)
  end

  def x_mas_count
    count = 0

    lines.each_with_index do |line, y|
      line.each_char.with_index do |char, x|
        next if char != "A"
        next if x.zero? || y.zero?
        next if x == lines[0].size - 1 || y == lines.size - 1

        cross_1 = lines[y - 1][x - 1] + lines[y][x] + lines[y + 1][x + 1]
        cross_2 = lines[y - 1][x + 1] + lines[y][x] + lines[y + 1][x - 1]

        count += 1 if [cross_1, cross_2].all? { ["MAS", "SAM"].include?(_1) }
      end
    end

    count
  end
end
