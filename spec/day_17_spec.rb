# frozen_string_literal: true

require_relative "../day-17/chronospatial_computer"

describe ChronospatialComputer, day: 17 do
  subject(:chronospatial_computer) { described_class.new(input) }

  context "with sample input", :sample do
    let(:input) do
      <<~INPUT
        Register A: 729
        Register B: 0
        Register C: 0

        Program: 0,1,5,4,3,0
      INPUT
    end

    it "finds the program output" do
      expect(chronospatial_computer.run.join(",")).to eq("4,6,3,5,6,3,5,2,1,0")
    end
  end

  it "finds the program output" do
    expect(chronospatial_computer.run.join(",")).to eq("7,1,3,4,1,2,6,7,1")
    expect(chronospatial_computer.find_initial_a).to eq(109_019_476_330_651)
  end
end
