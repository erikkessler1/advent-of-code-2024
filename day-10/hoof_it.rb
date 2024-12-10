# frozen_string_literal: true

class HoofIt
  include NewlineInput
  include Gridded

  def trailhead_scores
    starts.map do |start|
      to_visit = [[start, 0]]
      paths = Set.new

      until to_visit.empty?
        point, value = to_visit.pop
        if value == 9
          paths << point
          next
        end

        moves(point).each do |next_point|
          to_visit << [next_point, value + 1] if grid_value_at(next_point).to_i == value + 1
        end
      end

      paths.size
    end.sum
  end

  def trailhead_ratings
    starts.map do |start|
      to_visit = [[start, 0]]
      paths = 0

      until to_visit.empty?
        point, value = to_visit.pop
        if value == 9
          paths += 1
          next
        end

        moves(point).each do |next_point|
          to_visit << [next_point, value + 1] if grid_value_at(next_point).to_i == value + 1
        end
      end

      paths
    end.sum
  end

  private

  def moves(point)
    up = [point[0], point[1] - 1]
    down = [point[0], point[1] + 1]
    left = [point[0] - 1, point[1]]
    right = [point[0] + 1, point[1]]

    [up, down, left, right].select(&method(:on_grid?))
  end

  def starts
    starts = []
    each_point do |point, value|
      starts << point if value == "0"
    end

    starts
  end
end
