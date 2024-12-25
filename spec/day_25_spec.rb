# frozen_string_literal: true

require_relative "../day-25/code_chronicle"

describe CodeChronicle, day: 25 do
  subject(:code_chronicle) { described_class.new(input) }

  context "with sample input", :sample do
    let(:input) do
      <<~INPUT
        #####
        .####
        .####
        .####
        .#.#.
        .#...
        .....

        #####
        ##.##
        .#.##
        ...##
        ...#.
        ...#.
        .....

        .....
        #....
        #....
        #...#
        #.#.#
        #.###
        #####

        .....
        .....
        #.#..
        ###..
        ###.#
        ###.#
        #####

        .....
        .....
        .....
        #....
        #.#..
        #.#.#
        #####
      INPUT
    end

    specify do
      expect(code_chronicle.unique_locks).to eq(3)
    end
  end

  specify do
    expect(code_chronicle.unique_locks).to eq(3155)
  end
end
