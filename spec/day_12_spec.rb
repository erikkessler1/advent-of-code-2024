# frozen_string_literal: true

require_relative "../day-12/garden_groups"

describe GardenGroups, day: 12 do
  subject(:garden_groups) { described_class.new(input) }

  context "with sample input", :sample do
    # spell-checker: disable
    let(:input) do
      <<~INPUT
        RRRRIICCFF
        RRRRIICCCF
        VVRRRCCFFF
        VVRCCCJFFF
        VVVVCJJCFE
        VVIVCCJJEE
        VVIIICJJEE
        MIIIIIJJEE
        MIIISIJEEE
        MMMISSJEEE
      INPUT
    end
    # spell-checker: enable

    it "finds the total price" do
      expect(garden_groups.total_price).to eq([1930, 1206])
    end
  end

  it "finds the total price" do
    expect(garden_groups.total_price).to eq([1_486_324, 898_684])
  end
end
