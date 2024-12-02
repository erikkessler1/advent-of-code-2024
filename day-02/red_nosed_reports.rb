# frozen_string_literal: true

class RedNosedReports
  include NewlineInput

  def safe_reports(problem_dampener: false)
    reports.select { _1.safe?(problem_dampener: problem_dampener) }
  end

  private

  def reports
    @reports ||= lines.map { Report.new(_1.split.map(&:to_i)) }
  end

  class Report
    SAFE_DIFFERENCES = (-3..3).to_a.tap { _1.delete(0) }.freeze

    def initialize(levels)
      @levels = levels
    end

    def safe?(problem_dampener: false)
      @levels.each_with_index.reduce([nil, nil]) do |(last_last, last), (current, index)|
        next [nil, current] if last.nil?

        difference = last - current
        current_direction = difference.positive?
        last_direction = last_last.nil? ? current_direction : (last_last - last).positive?
        next [last, current] if SAFE_DIFFERENCES.include?(difference) && current_direction == last_direction

        return false unless problem_dampener

        # Go back 2 as it could be the first item that is the one we
        # want to remove (e.g., 3 1 2 3).
        return copy_without_level(index - 2).safe? ||
               copy_without_level(index - 1).safe? ||
               copy_without_level(index).safe?
      end

      true
    end

    private

    def copy_without_level(level)
      new_levels = @levels[0...level] + @levels[level + 1..]
      Report.new(new_levels)
    end
  end
end
