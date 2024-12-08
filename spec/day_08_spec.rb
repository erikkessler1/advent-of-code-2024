# frozen_string_literal: true

require_relative "../day-08/resonant_collinearity"

describe ResonantCollinearity, day: 8 do
  subject(:resonant_collinearity) { described_class.new(input) }

  context "with sample input", :sample do
    let(:input) do
      <<~INPUT
        ............
        ........0...
        .....0......
        .......0....
        ....0.......
        ......A.....
        ............
        ............
        ........A...
        .........A..
        ............
        ............
      INPUT
    end

    it "finds antinode locations", part: 1 do
      expect(resonant_collinearity.antinode_locations).to eq(14)
    end

    it "finds real antinode locations", part: 2 do
      expect(resonant_collinearity.real_antinode_locations).to eq(34)
    end
  end

  it "finds antinode_locations", part: 1 do
    expect(resonant_collinearity.antinode_locations).to eq(303)
  end

  it "finds real antinode locations", part: 2 do
    expect(resonant_collinearity.real_antinode_locations).to eq(1045)
  end
end
