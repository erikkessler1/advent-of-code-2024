# frozen_string_literal: true

require_relative "../day-20/race_condition"

describe RaceCondition, day: 20 do
  subject(:race_condition) { described_class.new(input) }

  context "with sample input", :sample do
    let(:input) do
      <<~INPUT
        ###############
        #...#...#.....#
        #.#.#.#.#.###.#
        #S#...#.#.#...#
        #######.#.#.###
        #######.#.#...#
        #######.#.###.#
        ###..E#...#...#
        ###.#######.###
        #...###...#...#
        #.#####.#.###.#
        #.#...#.#.#...#
        #.#.#.#.#.#.###
        #...#...#...###
        ###############
      INPUT
    end

    specify do
      expect(race_condition.cheats[64]).to eq(1)
      expect(race_condition.cheats(20)[76]).to eq(3)
    end
  end

  specify "#cheats", :slow do
    saves = race_condition.cheats
    expect(saves.sort.map { |s, c| s >= 100 ? c : 0 }.sum).to eq(1438)

    saves = race_condition.cheats(20)
    expect(saves.sort.map { |s, c| s >= 100 ? c : 0 }.sum).to eq(1_026_446)
  end
end
