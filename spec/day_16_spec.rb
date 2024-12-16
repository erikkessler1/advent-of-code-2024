# frozen_string_literal: true

require_relative "../day-16/reindeer_maze"

describe ReindeerMaze, day: 16 do
  subject(:reindeer_maze) { described_class.new(input) }

  context "with sample input", :sample do
    let(:input) do
      <<~INPUT
        ###############
        #.......#....E#
        #.#.###.#.###.#
        #.....#.#...#.#
        #.###.#####.#.#
        #.#.#.......#.#
        #.#.#####.###.#
        #...........#.#
        ###.#.#####.#.#
        #...#.....#.#.#
        #.#.#.###.#.#.#
        #.....#...#.#.#
        #.###.#.#.#.#.#
        #S..#.....#...#
        ###############
      INPUT
    end

    it "finds the best score" do
      expect(reindeer_maze.best_score).to eq([7036, 45])
    end
  end

  it "finds the best score", :slow do
    expect(reindeer_maze.best_score).to eq([88_468, 616])
  end
end
