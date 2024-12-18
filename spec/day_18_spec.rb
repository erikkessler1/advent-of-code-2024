# frozen_string_literal: true

require_relative "../day-18/ram_run"

describe RamRun, day: 18 do
  subject(:ram_run) { described_class.new(input, size: 71, space: 1024) }

  context "with sample input", :sample do
    subject(:ram_run) { described_class.new(input, size: 7, space: 12) }

    let(:input) do
      <<~INPUT
        5,4
        4,2
        4,5
        3,0
        2,1
        6,3
        2,4
        1,5
        0,6
        3,3
        2,6
        5,1
        1,2
        5,5
        2,5
        6,5
        1,4
        0,4
        6,4
        1,1
        6,1
        1,0
        0,5
        1,6
        2,0
      INPUT
    end

    it "finds steps to exit" do
      expect(ram_run.min_steps).to eq(22)
      expect(ram_run.blocker).to eq("6,1")
    end
  end

  it "finds steps to exit", :slow do
    expect(ram_run.min_steps).to eq(234)
    expect(ram_run.blocker).to eq("58,19")
  end
end
