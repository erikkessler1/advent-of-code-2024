# frozen_string_literal: true

class GardenGroups
  include NewlineInput
  include Gridded

  def total_price
    seen = Set.new
    groups = []

    each_point do |point, value|
      next if seen.include?(point)

      area = 0
      perimeter = 0
      sides = {
        right: Hash.new { |h, k| h[k] = [] },
        down: Hash.new { |h, k| h[k] = [] },
        left: Hash.new { |h, k| h[k] = [] },
        up: Hash.new { |h, k| h[k] = [] }
      }

      to_visit = [point]
      until to_visit.empty?
        visit = to_visit.pop
        next if seen.include?(visit)

        right = [visit[0] + 1, visit[1] + 0]
        down = [visit[0] + 0, visit[1] + 1]
        left = [visit[0] - 1, visit[1] + 0]
        up = [visit[0] + 0, visit[1] - 1]
        corner = [visit[0] + 1, visit[1] + 1]

        # If a square has no neighbors, it has a perimeter of 4, but
        # we remove 1 for each neighbor it does have.
        additional_perimeter = 4

        if on_grid?(right) && grid_value_at(right) == value
          additional_perimeter -= 1
          to_visit << right unless seen.include?(right)
        else
          sides[:right][right[0]] << [right, corner]
        end

        if on_grid?(down) && grid_value_at(down) == value
          additional_perimeter -= 1
          to_visit << down unless seen.include?(down)
        else
          sides[:down][down[1]] << [down, corner]
        end

        if on_grid?(left) && grid_value_at(left) == value
          additional_perimeter -= 1
          to_visit << left unless seen.include?(left)
        else
          sides[:left][visit[0]] << [visit, down]
        end

        if on_grid?(up) && grid_value_at(up) == value
          additional_perimeter -= 1
          to_visit << up unless seen.include?(up)
        else
          sides[:up][visit[1]] << [visit, right]
        end

        area += 1
        perimeter += additional_perimeter

        seen << visit
      end

      side_count = sides.values.flat_map(&:values).map do |side|
        sorted_segments = side.sort_by(&:first)
        sorted_segments.reduce([1, nil]) do |(count, last_end), segment|
          start = segment[0]
          new_end = segment[1]

          # Check if side continues growing
          if start == last_end || last_end.nil?
            [count, new_end]
          else
            [count + 1, new_end]
          end
        end.first
      end.sum

      groups << [value, area, perimeter, side_count]
    end

    [
      # Part 1
      groups.map { |_v, area, perimeter| area * perimeter }.sum,

      # Part 2
      groups.map { |_v, area, _p, sides| area * sides }.sum
    ]
  end
end
