# frozen_string_literal: true

class ReindeerMaze
  include NewlineInput
  include Gridded

  def best_score
    start = nil
    each_point do |point, value|
      break start = point if value == "S"
    end

    costs = []
    paths = Hash.new { |h, k| h[k] = [] }
    to_visit = [[start, ">", 0, []]]
    seen = {}
    until to_visit.empty?
      point, dir, cost, path = to_visit.pop
      seen_key = "#{point[0]},#{point[1]},#{dir}"
      path += [seen_key]

      if grid_value_at(point) == "E"
        paths[cost] << path
        costs << cost
        next
      end
      next if seen.key?(seen_key) && seen[seen_key] < cost

      right = [point[0] + 1, point[1] + 0]
      down = [point[0] + 0, point[1] + 1]
      left = [point[0] - 1, point[1] + 0]
      up = [point[0] + 0, point[1] - 1]

      seen[seen_key] = cost

      if grid_value_at(right) == "." || grid_value_at(right) == "E"
        new_cost = cost
        new_cost += 1000 if ["^", "v"].include?(dir)
        new_cost += 2000 if dir == "<"
        new_cost += 1
        to_visit << [right, ">", new_cost, path] unless new_cost > (costs.min || Float::INFINITY)
      end

      if grid_value_at(down) == "." || grid_value_at(down) == "E"
        new_cost = cost
        new_cost += 1000 if [">", "<"].include?(dir)
        new_cost += 2000 if dir == "^"
        new_cost += 1
        to_visit << [down, "v", new_cost, path] unless new_cost > (costs.min || Float::INFINITY)
      end

      if grid_value_at(left) == "." || grid_value_at(left) == "E"
        new_cost = cost
        new_cost += 1000 if ["^", "v"].include?(dir)
        new_cost += 2000 if dir == ">"
        new_cost += 1
        to_visit << [left, "<", new_cost, path] unless new_cost > (costs.min || Float::INFINITY)
      end

      if grid_value_at(up) == "." || grid_value_at(up) == "E" # rubocop:disable Style/Next
        new_cost = cost
        new_cost += 1000 if [">", "<"].include?(dir)
        new_cost += 2000 if dir == "v"
        new_cost += 1
        to_visit << [up, "^", new_cost, path] unless new_cost > (costs.min || Float::INFINITY)
      end
    end

    best_score = costs.min

    [
      best_score,
      paths[best_score].flatten.map { |x| x.split(",").take(2) }.uniq.count
    ]
  end
end
