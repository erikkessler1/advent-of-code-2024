# frozen_string_literal: true

require_relative "../day-19/linen_layout"

describe LinenLayout, day: 19 do
  subject(:linen_layout) { described_class.new(input) }

  context "with sample input", :sample do
    # spell-checker: disable
    let(:input) do
      <<~INPUT
        r, wr, b, g, bwu, rb, gb, br

        brwrr
        bggr
        gbbr
        rrbgbr
        ubwu
        bwurrg
        brgr
        bbrgwb
      INPUT
    end
    # spell-checker: enable

    specify do
      expect(linen_layout.possible_patterns).to eq(6)
      expect(linen_layout.all_ways).to eq(16)
    end
  end

  specify do
    expect(linen_layout.possible_patterns).to eq(233)
    expect(linen_layout.all_ways).to eq(691_316_989_225_259)
  end
end
