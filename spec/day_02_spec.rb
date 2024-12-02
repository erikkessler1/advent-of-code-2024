# frozen_string_literal: true

require_relative "../day-02/red_nosed_reports"

describe RedNosedReports, day: 2 do
  subject(:red_nosed_reports) { described_class.new(input) }

  context "with sample input", :sample do
    let(:input) do
      <<~INPUT
        7 6 4 2 1
        1 2 7 8 9
        9 7 6 2 1
        1 3 2 4 5
        8 6 4 4 1
        1 3 6 7 9
      INPUT
    end

    it "finds safe reports", part: 1 do
      expect(red_nosed_reports.safe_reports.count).to eq(2)
    end

    context "with the Problem Dampener" do
      it "finds safe reports", part: 2 do
        expect(red_nosed_reports.safe_reports(problem_dampener: true).count).to eq(4)
      end
    end
  end

  it "finds safe reports", part: 1 do
    expect(red_nosed_reports.safe_reports.count).to eq(510)
  end

  context "with the Problem Dampener" do
    it "finds safe reports", part: 2 do
      expect(red_nosed_reports.safe_reports(problem_dampener: true).count).to eq(553)
    end
  end
end
