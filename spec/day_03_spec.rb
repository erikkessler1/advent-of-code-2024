# frozen_string_literal: true

# spell-checker:words muls xmul

require_relative "../day-03/mull_it_over"

describe MullItOver, day: 3 do
  subject(:mull_it_over) { described_class.new(input) }

  context "with sample input", :sample do
    let(:input) do
      <<~INPUT
        xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))
      INPUT
    end

    it "finds the muls", part: 1 do
      expect(mull_it_over.mul).to eq(161)
    end

    it "finds the conditional muls", part: 2 do
      expect(mull_it_over.conditional_mul).to eq(48)
    end
  end

  it "finds the muls", part: 1 do
    expect(mull_it_over.mul).to eq(170_807_108)
  end

  it "finds the conditional muls", part: 2 do
    expect(mull_it_over.conditional_mul).to eq(74_838_033)
  end
end
