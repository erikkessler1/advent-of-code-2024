# frozen_string_literal: true

require_relative "../day-22/monkey_market"

describe MonkeyMarket, day: 22 do
  subject(:monkey_market) { described_class.new(input) }

  context "with sample input", :sample do
    let(:input) do
      <<~INPUT
        1
        10
        100
        2024
      INPUT
    end

    specify do
      expect(monkey_market.secret_number).to eq(37_327_623)
      expect(monkey_market.delta_sequence).to eq(24)
    end
  end

  it "finds secret numbers", :slow do
    expect(monkey_market.secret_number).to eq(17_960_270_302)
    expect(monkey_market.delta_sequence).to eq(2042)
  end
end
