# frozen_string_literal: true

class MonkeyMarket
  include NewlineInput

  def secret_number
    lines.map do |line|
      n = line.to_i
      2000.times do
        n ^= (n * 64)
        n %= 16_777_216

        n ^= (n / 32)
        n %= 16_777_216

        n ^= (n * 2048)
        n %= 16_777_216
      end

      n
    end.sum
  end

  def delta_sequence
    sequences = Hash.new { |h, k| h[k] = Array.new(lines.size) }

    lines.each_with_index do |line, i|
      n = line.to_i
      price = n % 10
      deltas = []

      2000.times do
        n ^= (n * 64)
        n %= 16_777_216

        n ^= (n / 32)
        n %= 16_777_216

        n ^= (n * 2048)
        n %= 16_777_216

        new_price = n % 10
        delta = new_price - price
        deltas << delta
        p delta if line == "2"
        if deltas.size >= 4
          last_four = deltas[deltas.size - 4..]
          sequences[last_four][i] ||= new_price
        end

        price = new_price
      end
    end

    sequences.values.map { _1.compact.sum }.max
  end
end
