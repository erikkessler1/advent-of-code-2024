# frozen_string_literal: true

require_relative "../day-13/claw_contraption"

describe ClawContraption, day: 13 do
  subject(:claw_contraption) { described_class.new(input) }

  context "with sample input", :sample do
    let(:input) do
      <<~INPUT
        Button A: X+94, Y+34
        Button B: X+22, Y+67
        Prize: X=8400, Y=5400

        Button A: X+26, Y+66
        Button B: X+67, Y+21
        Prize: X=12748, Y=12176

        Button A: X+17, Y+86
        Button B: X+84, Y+37
        Prize: X=7870, Y=6450

        Button A: X+69, Y+23
        Button B: X+27, Y+71
        Prize: X=18641, Y=10279
      INPUT
    end

    it "finds the min cost" do
      expect(claw_contraption.min_cost).to eq(480)
    end
  end

  it "finds the min cost" do
    expect(claw_contraption.min_cost).to eq(31_552)
    expect(claw_contraption.min_cost(offset: 10**13)).to eq(95_273_925_552_482)
  end
end
