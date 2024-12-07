# frozen_string_literal: true

require_relative "../day-07/bridge_repair"

describe BridgeRepair, day: 7 do
  subject(:bridge_repair) { described_class.new(input) }

  context "with sample input", :sample do
    let(:input) do
      <<~INPUT
        190: 10 19
        3267: 81 40 27
        83: 17 5
        156: 15 6
        7290: 6 8 6 15
        161011: 16 10 13
        192: 17 8 14
        21037: 9 7 18 13
        292: 11 6 16 20
      INPUT
    end

    it "finds the calibration result", part: 1 do
      expect(bridge_repair.calibration_result).to eq(3_749)
    end

    it "finds the real calibration result", part: 2 do
      expect(bridge_repair.real_calibration_result).to eq(11_387)
    end
  end

  it "finds the calibration result", part: 1 do
    expect(bridge_repair.calibration_result).to eq(14_711_933_466_277)
  end

  it "finds the real calibration result", :slow, part: 2 do
    expect(bridge_repair.real_calibration_result).to eq(286_580_387_663_654)
  end
end
