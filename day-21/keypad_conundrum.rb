# frozen_string_literal: true

class KeypadConundrum
  include NewlineInput

  BUTTON_POSITIONS = {
    "A" => [2, 3],
    "0" => [1, 3],
    "1" => [0, 2],
    "2" => [1, 2],
    "3" => [2, 2],
    "4" => [0, 1],
    "5" => [1, 1],
    "6" => [2, 1],
    "7" => [0, 0],
    "8" => [1, 0],
    "9" => [2, 0]
  }.freeze

  def complexity(robots = 2)
    lines.map do |code|
      positions = code.each_char.map(&method(:button_position))

      robot_positions = [
        [2, 3],
        *[[2, 0]] * robots
      ]
      presses = positions.map do |position|
        min_presses(robot_positions, position, 0).tap do
          robot_positions[0] = position
        end.first
      end.sum

      code.to_i * presses
    end.sum
  end

  private

  def min_presses(robot_positions, target, level)
    return [1, robot_positions] if level == robot_positions.size

    current = robot_positions[level]
    cache_key = [robot_positions[level..].to_s, target]
    return cache[cache_key] if cache.key?(cache_key)

    move_sets = possible_moves(current, target, level)

    move_sets.map do |moves|
      positions = robot_positions.dup
      cost = moves.map do |move|
        min_presses(positions, move, level + 1).tap do |_new_cost, new_positions|
          ((level + 1)...robot_positions.size).each do |i|
            positions[i] = level == i - 1 ? move : new_positions[i]
          end
        end.first
      end.sum

      [cost, positions]
    end.min_by(&:first).tap do
      cache[cache_key] = [_1, _2]
    end
  end

  def possible_moves(current, target, level)
    return [[[2, 0]]] if current == target

    moves = []

    # 1: Need UP + LEFT
    if current[0] > target[0] && current[1] > target[1]
      # We can't go through [0, 3]
      if level != 0 || (target[0] != 0 || current[1] != 3)
        moves << [
          *[[0, 1]] * (current[0] - target[0]), # <
          *[[1, 0]] * (current[1] - target[1]), # ^
          [2, 0]
        ]
      end

      moves << [
        *[[1, 0]] * (current[1] - target[1]), # ^
        *[[0, 1]] * (current[0] - target[0]), # <
        [2, 0]
      ]
    end

    # 2: Need LEFT
    if current[0] > target[0] && current[1] == target[1]
      moves << [*[[0, 1]] * (current[0] - target[0]), [2, 0]] # <
    end

    # 3: Need DOWN + LEFT
    if current[0] > target[0] && current[1] < target[1]
      # We can't go through [0, 0]
      if level.zero? || (target[0] != 0 || current[1] != 0)
        moves << [
          *[[0, 1]] * (current[0] - target[0]), # <
          *[[1, 1]] * (target[1] - current[1]), # v
          [2, 0]
        ]
      end

      moves << [
        *[[1, 1]] * (target[1] - current[1]), # v
        *[[0, 1]] * (current[0] - target[0]), # <
        [2, 0]
      ]
    end

    # 4: Need RIGHT + UP
    if current[0] < target[0] && current[1] > target[1]
      moves << [
        *[[2, 1]] * (target[0] - current[0]), # >
        *[[1, 0]] * (current[1] - target[1]), # ^
        [2, 0]
      ]

      # We can't go though [0, 0]
      if level.zero? || (target[1] != 0 || current[0] != 0)
        moves << [
          *[[1, 0]] * (current[1] - target[1]), # ^
          *[[2, 1]] * (target[0] - current[0]), # >
          [2, 0]
        ]
      end
    end

    # 5: Need RIGHT
    if current[0] < target[0] && current[1] == target[1]
      moves << [*[[2, 1]] * (target[0] - current[0]), [2, 0]] # >
    end

    # 6: Need RIGHT + DOWN
    if current[0] < target[0] && current[1] < target[1]
      moves << [
        *[[2, 1]] * (target[0] - current[0]), # >
        *[[1, 1]] * (target[1] - current[1]), # v
        [2, 0]
      ]

      # We can't go through [0, 3]
      if level != 0 || (target[1] != 3 || current[0] != 0)
        moves << [
          *[[1, 1]] * (target[1] - current[1]), # v
          *[[2, 1]] * (target[0] - current[0]), # >
          [2, 0]
        ]
      end
    end

    # 7: Need UP
    if current[0] == target[0] && current[1] > target[1]
      moves << [*[[1, 0]] * (current[1] - target[1]), [2, 0]] # ^
    end

    # 8: Need DOWN
    if current[0] == target[0] && current[1] < target[1]
      moves << [*[[1, 1]] * (target[1] - current[1]), [2, 0]] # v
    end

    moves
  end

  def cache
    @cache ||= {}
  end

  def button_position(button)
    BUTTON_POSITIONS.fetch(button)
  end
end
