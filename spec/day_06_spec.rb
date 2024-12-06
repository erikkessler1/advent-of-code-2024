# frozen_string_literal: true

require_relative "../day-06/guard_gallivant"

describe GuardGallivant, day: 6 do
  subject(:guard_gallivant) { described_class.new(input) }

  context "with sample input", :sample do
    let(:input) do
      <<~INPUT
        ....#.....
        .........#
        ..........
        ..#.......
        .......#..
        ..........
        .#..^.....
        ........#.
        #.........
        ......#...
      INPUT
    end

    it "finds distinct positions", part: 1 do
      expect(guard_gallivant.distinct_positions).to eq(41)
    end

    it "finds cycle positions", part: 2 do
      expect(guard_gallivant.cycle_positions).to eq(6)
    end
  end

  it "finds distinct positions", part: 1 do
    expect(guard_gallivant.distinct_positions).to eq(4_977)
  end

  it "finds cycle positions", :slow, part: 2 do
    expect(guard_gallivant.cycle_positions).to eq(1_729)
  end
end
