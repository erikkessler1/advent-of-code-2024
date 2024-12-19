# frozen_string_literal: true

class LinenLayout
  include NewlineInput

  def possible_patterns
    patterns = lines.first.split(", ")

    lines.drop(2).count do |target|
      possible?(target, patterns)
    end
  end

  def all_ways
    patterns = lines.first.split(", ")

    lines.drop(2).map do |target|
      possible_count(target, patterns)
    end.sum
  end

  private

  def possible?(target, patterns)
    return true if target.empty?

    patterns.any? do |pattern|
      next false unless target.start_with?(pattern)

      possible?(target[pattern.size...], patterns)
    end
  end

  def possible_count(target, patterns)
    return count_cache[target] if count_cache.key?(target)
    return 1 if target.empty?

    patterns.map do |pattern|
      next 0 unless target.start_with?(pattern)

      possible_count(target[pattern.size...], patterns)
    end.sum.tap do |c|
      count_cache[target] = c
    end
  end

  def count_cache
    @count_cache ||= {}
  end
end
