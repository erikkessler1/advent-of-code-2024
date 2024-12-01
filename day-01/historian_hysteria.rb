# frozen_string_literal: true

class HistorianHysteria
  include NewlineInput

  def total_distance
    list_a.sort.zip(list_b.sort).map do
      (_1 - _2).abs
    end.sum
  end

  def similarity_score
    list_a.map do
      list_b.count(_1) * _1
    end.sum
  end

  private

  def list_a
    @list_a ||= locations.map(&:first)
  end

  def list_b
    @list_b ||= locations.map(&:last)
  end

  def locations
    @locations ||= lines.map { _1.split.map(&:to_i) }
  end
end
