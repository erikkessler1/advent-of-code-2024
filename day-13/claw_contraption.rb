# frozen_string_literal: true

class ClawContraption
  include NewlineInput

  GAME_REGEX = /Button A: X\+(\d+), Y\+(\d+)Button B: X\+(\d+), Y\+(\d+)Prize: X=(\d+), Y=(\d+)/

  def min_cost(offset: 0)
    games.map do |ax, ay, bx, by, px, py|
      px += offset
      py += offset

      b = ((ax * py) - (ay * px)) / ((-1 * ay * bx) + (ax * by)).to_f
      a = (px - (bx * b)) / ax
      next 0 unless (a % 1).zero? && (b % 1).zero?

      ((3 * a) + b).to_i
    end.sum
  end

  private

  def games
    @games ||= lines.join.scan(GAME_REGEX).map do |game|
      game.map(&:to_i)
    end
  end
end
