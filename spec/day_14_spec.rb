# frozen_string_literal: true

require_relative "../day-14/restroom_redoubt"

describe RestroomRedoubt, day: 14 do
  subject(:restroom_redoubt) { described_class.new(input) }

  context "with sample input", :sample do
    let(:input) do
      <<~INPUT
        p=0,4 v=3,-3
        p=6,3 v=-1,-3
        p=10,3 v=-1,2
        p=2,0 v=2,-1
        p=0,0 v=1,3
        p=3,0 v=-2,-2
        p=7,6 v=-1,-3
        p=3,0 v=-1,-2
        p=9,3 v=2,3
        p=7,3 v=-1,2
        p=2,4 v=2,-3
        p=9,5 v=-3,-3
      INPUT
    end

    specify "#safety_factor", part: 1 do
      expect(restroom_redoubt.safety_factor(mid_x: 5, mid_y: 3)).to eq(12)
    end
  end

  specify "#safety_factor", part: 1 do
    expect(restroom_redoubt.safety_factor).to eq(215_987_200)
  end
end
