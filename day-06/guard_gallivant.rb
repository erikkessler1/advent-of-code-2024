# frozen_string_literal: true

class GuardGallivant
  include NewlineInput
  include Gridded

  def distinct_positions
    cur_pos = nil
    cur_dir = [0, -1]
    seen_pos = Set.new

    lines.each_with_index do |line, y|
      line.each_char.with_index do |char, x|
        if char == "^"
          cur_pos = [x, y]
          break
        end
      end
    end

    loop do
      seen_pos << cur_pos
      next_pos = [cur_pos[0] + cur_dir[0], cur_pos[1] + cur_dir[1]]

      if off_grid?(next_pos)
        break
      elsif grid_value_at(next_pos) == "#"
        cur_dir = [-1 * cur_dir[1], cur_dir[0]]
      else
        cur_pos = next_pos
      end
    end

    seen_pos.size
  end

  def cycle_positions
    cur_pos = nil
    cur_dir = [0, -1]
    seen_pos = Hash.new { |hash, key| hash[key] = [] }

    lines.each_with_index do |line, y|
      line.each_char.with_index do |char, x|
        if char == "^"
          cur_pos = [x, y]
          break
        end
      end
    end

    cycles = Set.new

    loop do
      next_pos = [cur_pos[0] + cur_dir[0], cur_pos[1] + cur_dir[1]]

      if off_grid?(next_pos)
        break
      elsif lines[next_pos[1]]&.send(:[], next_pos[0]) == "#"
        seen_pos[cur_pos] << cur_dir
        cur_dir = [-1 * cur_dir[1], cur_dir[0]]
      else
        cycle_cur_pos = cur_pos
        cycle_cur_dir = cur_dir
        cycle_seen_pos = seen_pos.dup.tap { |seen| seen.transform_values!(&:dup) }
        obs_pos = next_pos

        loop do
          break if seen_pos.key?(obs_pos)

          if (cycle_seen_pos[cycle_cur_pos] || []).include?(cycle_cur_dir)
            cycles << obs_pos
            break
          end

          cycle_next_pos = [cycle_cur_pos[0] + cycle_cur_dir[0], cycle_cur_pos[1] + cycle_cur_dir[1]]

          if off_grid?(cycle_next_pos)
            break
          elsif cycle_next_pos == obs_pos || grid_value_at(cycle_next_pos) == "#"
            cycle_seen_pos[cycle_cur_pos] << cycle_cur_dir
            cycle_cur_dir = [-1 * cycle_cur_dir[1], cycle_cur_dir[0]]
          else
            cycle_seen_pos[cycle_cur_pos] << cycle_cur_dir
            cycle_cur_pos = cycle_next_pos
          end
        end

        seen_pos[cur_pos] << cur_dir
        cur_pos = next_pos
      end
    end

    cycles.size
  end
end
