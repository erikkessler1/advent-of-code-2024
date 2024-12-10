# frozen_string_literal: true

require_relative "../day-10/hoof_it"

describe HoofIt, day: 10 do
  subject(:hoof_it) { described_class.new(input) }

  context "with sample input", :sample do
    let(:input) do
      <<~INPUT
        89010123
        78121874
        87430965
        96549874
        45678903
        32019012
        01329801
        10456732
      INPUT
    end

    it "finds trailhead scores", part: 1 do
      expect(hoof_it.trailhead_scores).to eq(36)
    end

    it "finds trailhead ratings", part: 2 do
      expect(hoof_it.trailhead_ratings).to eq(81)
    end
  end

  it "finds trailhead scores", part: 1 do
    expect(hoof_it.trailhead_scores).to eq(782)
  end

  it "finds trailhead ratings", part: 2 do
    expect(hoof_it.trailhead_ratings).to eq(1694)
  end
end
