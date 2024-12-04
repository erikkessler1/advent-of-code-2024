# frozen_string_literal: true

require_relative "../day-04/ceres_search"

describe CeresSearch, day: 4 do
  subject(:ceres_search) { described_class.new(input) }

  context "with sample input", :sample do
    # spell-checker: disable
    let(:input) do
      <<~INPUT
        MMMSXXMASM
        MSAMXMSMSA
        AMXSXMAAMM
        MSAMASMSMX
        XMASAMXAMM
        XXAMMXXAMA
        SMSMSASXSS
        SAXAMASAAA
        MAMMMXMMMM
        MXMXAXMASX
      INPUT
    end
    # spell-checker: enable

    it "finds xmas", part: 1 do
      expect(ceres_search.xmas_count).to eq(18)
    end

    it "finds x-mas", part: 2 do
      expect(ceres_search.x_mas_count).to eq(9)
    end
  end

  it "finds xmas", part: 1 do
    expect(ceres_search.xmas_count).to eq(2_458)
  end

  it "finds x-mas", part: 2 do
    expect(ceres_search.x_mas_count).to eq(1_945)
  end
end
