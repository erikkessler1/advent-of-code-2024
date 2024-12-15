# frozen_string_literal: true

class WarehouseWoes
  include NewlineInput
  include Gridded

  DIRS = {
    ">" => [1, 0],
    "v" => [0, 1],
    "<" => [-1, 0],
    "^" => [0, -1]
  }.freeze

  def gps_coordinates
    robot = find_robot
    make_movements(robot)
    compute_gps
  end

  private

  def find_robot
    each_point do |point, value|
      return point if value == "@"
    end
  end

  def make_movements(robot)
    movements.each do |movement|
      dir = DIRS[movement]
      to_move = []
      movers = [robot]

      loop do
        new_movers = []
        movers.each do |mover|
          new_mover = [mover[0] + dir[0], mover[1] + dir[1]]
          if grid_value_at(new_mover) == "#"
            break (to_move = []
                   new_movers = [])
          end

          mover_value = grid_value_at(mover)
          new_mover_value = grid_value_at(new_mover)
          to_move << [mover_value, new_mover]
          new_movers << new_mover if new_mover_value != "."

          next unless ["^", "v"].include?(movement)

          if new_mover_value == "]" && !movers.include?([mover[0] - 1, mover[1]])
            extra_mover = [new_mover[0] - 1, new_mover[1]]
            to_move << [".", extra_mover]
            new_movers << extra_mover
          end

          next unless new_mover_value == "[" && !movers.include?([mover[0] + 1, mover[1]])

          extra_mover = [new_mover[0] + 1, new_mover[1]]
          to_move << [".", extra_mover]
          new_movers << extra_mover
        end
        break if new_movers.empty?

        movers = new_movers
      end

      to_move.each do |value, new_point|
        update_grid_value(new_point, value)
        if value == "@"
          update_grid_value(robot, ".")
          robot = new_point
        end
      end
    end
  end

  def compute_gps(box_value = "O")
    gps = 0
    each_point do |point, value|
      next unless value == box_value

      gps += point[0] + (100 * point[1])
    end

    gps
  end

  def grid_lines
    @grid_lines ||= lines.take_while { !_1.empty? }
  end

  def movements
    @movements ||= lines.drop_while { !_1.empty? }.join.each_char
  end
end

class ScaledWarehouseWoes < WarehouseWoes
  private

  def compute_gps
    super("[")
  end

  def grid_lines
    @grid_lines ||= super.map { |line| line.gsub("#", "##").gsub(".", "..").gsub("O", "[]").sub("@", "@.") }
  end
end
