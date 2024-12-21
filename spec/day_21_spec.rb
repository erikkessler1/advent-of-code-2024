# frozen_string_literal: true

require_relative "../day-21/keypad_conundrum"

describe KeypadConundrum, day: 21 do
  subject(:keypad_conundrum) { described_class.new(input) }

  context "with sample input", :sample do
    let(:input) do
      <<~INPUT
        029A
        980A
        179A
        456A
        379A
      INPUT
    end

    specify do
      expect(keypad_conundrum.complexity).to eq(126_384)
    end
  end

  # Part 1
  specify { expect(keypad_conundrum.complexity).to eq(176_650) }

  # Part 2
  specify { expect(keypad_conundrum.complexity(25)).to eq(217_698_355_426_872) }
end
