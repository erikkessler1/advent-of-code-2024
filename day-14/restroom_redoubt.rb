# frozen_string_literal: true

class RestroomRedoubt
  include NewlineInput

  def safety_factor(seconds: 100, mid_x: 50, mid_y: 51)
    width = (mid_x * 2) + 1
    height = (mid_y * 2) + 1

    final_positions = positions(seconds, width, height)
    final_positions.each_with_object([0, 0, 0, 0]) do |robot, quads|
      quads[0] += 1 if robot[0] < mid_x && robot[1] < mid_y
      quads[1] += 1 if robot[0] < mid_x && robot[1] > mid_y
      quads[2] += 1 if robot[0] > mid_x && robot[1] > mid_y
      quads[3] += 1 if robot[0] > mid_x && robot[1] < mid_y
    end.reduce(&:*)
  end

  def xmas_tree
    width = 101
    height = 103

    # This time is when a pattern starts to come into focus. We'll
    # check every 101 seconds after this.
    t = 71

    loop do
      break if t >= 10_000
      next t += 1 unless t == 8050 # part 2 answer

      positions = positions(t, width, height).to_set

      puts "\n\n\n"
      puts "T: #{t}"
      height.times do |y|
        width.times do |x|
          if positions.include?([x, y])
            print "X"
          else
            print " "
          end
        end
        puts "\n"
      end

      t += width
      sleep(0.1)
    end
  end

  private

  def positions(seconds, width, height)
    robots.map { |x, y, dx, dy| [(x + (dx * seconds)) % width, (y + (dy * seconds)) % height] }
  end

  def robots
    @robots ||= lines.map do |line|
      match_data = line.match(/p=(\d+),(\d+) v=(-?\d+),(-?\d+)/)
      match_data.captures.map(&:to_i)
    end
  end
end
