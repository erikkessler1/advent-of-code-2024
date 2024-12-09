# frozen_string_literal: true

require_relative "../day-09/disk_fragmenter"

describe DiskFragmenter, day: 9 do
  subject(:disk_fragmenter) { described_class.new(input) }

  context "with sample input", :sample do
    let(:input) do
      <<~INPUT
        2333133121414131402
      INPUT
    end

    it "finds the filesystem checksum", part: 1 do
      expect(disk_fragmenter.filesystem_checksum).to eq(1928)
    end

    it "finds the filesystem checksum with whole files", part: 2 do
      expect(disk_fragmenter.filesystem_checksum_whole_files).to eq(2858)
    end
  end

  it "finds the filesystem checksum", part: 1 do
    expect(disk_fragmenter.filesystem_checksum).to eq(6_200_294_120_911)
  end

  it "finds the filesystem checksum with whole files", :slow, part: 2 do
    expect(disk_fragmenter.filesystem_checksum_whole_files).to eq(6_227_018_762_750)
  end
end
