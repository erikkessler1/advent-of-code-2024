# frozen_string_literal: true

class RaceCondition
  include NewlineInput
  include Gridded

  def cheats(max_diff = 2)
    start = nil
    each_point do |point, value|
      break start = point if value == "S"
    end

    to_visit = [[start, [], nil]]
    base_path = nil
    seen = Set.new
    until to_visit.empty?
      point, path, cheat = to_visit.pop
      path += [point]
      break base_path = path if grid_value_at(point) == "E"
      next if seen.include?(point)

      seen << point

      right = [point[0] + 1, point[1] + 0]
      down = [point[0] + 0, point[1] + 1]
      left = [point[0] - 1, point[1] + 0]
      up = [point[0] + 0, point[1] - 1]

      [right, down, left, up].each do |next_point|
        next if off_grid?(next_point)
        next if grid_value_at(next_point) == "#"

        to_visit << [next_point, path, cheat]
      end
    end

    saves = Hash.new { |h, k| h[k] = 0 }
    base_path.each_with_index do |(ax, ay), i|
      base_path.each_with_index do |(bx, by), j|
        next if j <= i

        diff = (ax - bx).abs + (ay - by).abs
        next unless diff > 1 && diff <= max_diff

        saves[j - i - diff] += 1
      end
    end

    saves
  end
end
