# frozen_string_literal: true

require_relative "../day-11/plutonian_pebbles"

describe PlutonianPebbles, day: 11 do
  subject(:plutonian_pebbles) { described_class.new(input) }

  context "with sample input", :sample do
    let(:input) do
      <<~INPUT
        125 17
      INPUT
    end

    it "counts stones" do
      expect(plutonian_pebbles.blink(25)).to eq(55_312)
    end
  end

  it "counts stones" do
    expect(plutonian_pebbles.blink(25)).to eq(224_529)
    expect(plutonian_pebbles.blink(75)).to eq(266_820_198_587_914)
  end
end
