# frozen_string_literal: true

require_relative "../day-01/historian_hysteria"

describe HistorianHysteria, day: 1 do
  subject(:historian_hysteria) { described_class.new(input) }

  it "finds the total distance", part: 1 do
    expect(historian_hysteria.total_distance).to eq(1_258_579)
  end

  it "finds the similarity score", part: 2 do
    expect(historian_hysteria.similarity_score).to eq(23_981_443)
  end
end
