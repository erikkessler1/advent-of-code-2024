# frozen_string_literal: true

class ResonantCollinearity
  include NewlineInput
  include Gridded

  def antinode_locations
    antinodes = pairs.map do |(a, b)|
      ax, ay = a
      bx, by = b

      dx = bx - ax
      dy = by - ay

      [
        [bx + dx, by + dy],
        [ax - dx, ay - dy]
      ]
    end

    antinodes.flatten(1).select(&method(:on_grid?)).uniq.count
  end

  def real_antinode_locations
    antinodes = Set.new

    pairs.each do |(a, b)|
      ax, ay = a
      bx, by = b

      dx = bx - ax
      dy = by - ay

      antinodes << a
      antinodes << b

      nx = bx
      ny = by
      loop do
        nx += dx
        ny += dy
        antinode = [nx, ny]
        break if off_grid?(antinode)

        antinodes << antinode
      end

      nx = ax
      ny = ay
      loop do
        nx -= dx
        ny -= dy
        antinode = [nx, ny]
        break if off_grid?(antinode)

        antinodes << antinode
      end
    end

    antinodes.size
  end

  private

  def pairs
    nodes = Hash.new { |h, k| h[k] = [] }

    each_point do |point, value|
      next if value == "."

      nodes[value] << point
    end

    nodes.values.map do |locations|
      locations.map.with_index do |a, i|
        locations.drop(i + 1).map { |b| [a, b] }
      end.flatten(1)
    end.flatten(1)
  end
end
