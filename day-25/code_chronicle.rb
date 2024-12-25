# frozen_string_literal: true

class CodeChronicle
  include NewlineInput

  def unique_locks
    locks = []
    keys = []

    current_item = Array.new(5) { Array.new(7) }
    y = 0
    lines.each do |line|
      if line.empty?
        if current_item.all? { _1.first == 1 }
          locks << current_item
        else
          keys << current_item
        end

        current_item = Array.new(5) { Array.new(7) }
        y = 0
        next
      end

      line.each_char.with_index do |char, x|
        current_item[x][y] = char == "#" ? 1 : 0
      end

      y += 1
    end

    if current_item.all? { _1.first == 1 }
      locks << current_item
    else
      keys << current_item
    end

    locks = locks.map { _1.map(&:sum) }
    keys = keys.map { _1.map(&:sum) }

    result = 0
    keys.each do |key|
      locks.each do |lock|
        result += 1 if key.zip(lock).map(&:sum).all? { _1 <= 7 }
      end
    end

    result
  end
end
