# frozen_string_literal: true

class RamRun
  include NewlineInput
  include Gridded

  def initialize(input, size:, space:)
    super(input)

    @space = space
    @memory = Array.new(size) { Array.new(size) { "." } }
    @goal = [size - 1, size - 1]

    corrupt_bytes = lines.take(space).map { _1.split(",").map(&:to_i) }
    corrupt_bytes.each do |point|
      update_grid_value(point, "#")
    end
  end

  def min_steps
    to_visit = [[[0, 0], 0]]
    seen = Set.new
    until to_visit.empty?
      point, size = to_visit.shift
      next if seen.include?(point)

      size += 1
      seen << point
      return size - 1 if point == @goal

      right = [point[0] + 1, point[1] + 0]
      down = [point[0] + 0, point[1] + 1]
      left = [point[0] - 1, point[1] + 0]
      up = [point[0] + 0, point[1] - 1]

      [right, down, left, up].each do |next_point|
        to_visit << [next_point, size] if on_grid?(next_point) && grid_value_at(next_point) == "."
      end
    end

    nil
  end

  def blocker
    lines.drop(@space).map { _1.split(",").map(&:to_i) }.each do |point|
      update_grid_value(point, "#")
      return point.join(",") if min_steps.nil?
    end
  end

  private

  def grid_lines
    @memory
  end
end
