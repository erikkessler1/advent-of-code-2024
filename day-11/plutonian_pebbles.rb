# frozen_string_literal: true

class PlutonianPebbles
  include NewlineInput

  class MemoStone
    def initialize(value, parent, memo, offset)
      @value = value
      @parent = parent
      @memo = memo
      @offset = offset
    end

    def blink
      @offset += 1

      additional = @memo[@value][@offset]
      @parent.on_blink(additional, offset: @offset + 1)

      self
    end

    def count
      @memo[@value][@offset]
    end

    def to_s
      "#{@value}@#{@offset}"
    end

    alias_method :inspect, :to_s
  end

  class Stone
    def self.memo_or_new(value, parent, memo)
      return MemoStone.new(value, parent, memo, 0) if memo.key?(value)

      new(value, parent, memo)
    end

    def initialize(value, parent, memo)
      @value = value
      @parent = parent
      @memo = memo

      # 1 stone initially
      @memo[value][0] = 1
    end

    def on_blink(additional, offset:)
      existing = @memo[@value][offset] || 0
      @memo[@value][offset] = existing + additional
      @parent&.on_blink(additional, offset: offset + 1)
    end

    def blink
      stones = next_stones

      count = stones.is_a?(Array) ? 2 : 1
      @memo[@value][1] = count
      @parent&.on_blink(count, offset: 2)

      stones
    end

    def count
      1
    end

    def to_s
      @value.to_s
    end

    alias_method :inspect, :to_s

    private

    def next_stones
      return Stone.memo_or_new(1, self, @memo) if @value.zero?

      digits = Math.log10(@value + 1).ceil
      return Stone.memo_or_new(@value * 2024, self, @memo) if digits.odd?

      move = 10**(digits / 2)
      [
        Stone.memo_or_new(@value / move, self, @memo),
        Stone.memo_or_new(@value % move, self, @memo)
      ]
    end
  end

  def blink(x, stones: lines[0].split.map(&:to_i))
    memo = Hash.new { |h, k| h[k] = {} }
    stones = stones.map { Stone.new(_1, nil, memo) }

    x.times do
      stones = stones.flat_map(&:blink)
    end

    stones.map(&:count).sum
  end
end
