# frozen_string_literal: true

require_relative "../day-23/lan_party"

describe LanParty, day: 23 do
  subject(:lan_party) { described_class.new(input) }

  context "with sample input", :sample do
    let(:input) do
      <<~INPUT
        kh-tc
        qp-kh
        de-cg
        ka-co
        yn-aq
        qp-ub
        cg-tb
        vc-aq
        tb-ka
        wh-tc
        yn-cg
        kh-ub
        ta-co
        de-co
        tc-td
        tb-wq
        wh-td
        ta-ka
        td-qp
        aq-cg
        wq-ub
        ub-vc
        de-ta
        wq-aq
        wq-vc
        wh-yn
        ka-de
        kh-ta
        co-tc
        wh-qp
        tb-vc
        td-yn
      INPUT
    end

    specify do
      expect(lan_party.connected.count).to eq(7)
      expect(lan_party.max_connected.count).to eq(4)
    end
  end

  specify do
    expect(lan_party.connected.count).to eq(926)
    expect(lan_party.max_connected.join(",")).to eq("az,ed,hz,it,ld,nh,pc,td,ty,ux,wc,yg,zz")
  end
end
