# frozen_string_literal: true

require_relative "../day-15/warehouse_woes"

describe WarehouseWoes, day: 15 do
  subject(:warehouse_woes) { described_class.new(input) }

  context "with sample input", :sample do
    let(:input) do
      <<~INPUT
        ##########
        #..O..O.O#
        #......O.#
        #.OO..O.O#
        #..O@..O.#
        #O#..O...#
        #O..O..O.#
        #.OO.O.OO#
        #....O...#
        ##########

        <vv>^<v^>v>^vv^v>v<>v^v<v<^vv<<<^><<><>>v<vvv<>^v^>^<<<><<v<<<v^vv^v>^
        vvv<<^>^v^^><<>>><>^<<><^vv^^<>vvv<>><^^v>^>vv<>v<<<<v<^v>^<^^>>>^<v<v
        ><>vv>v^v^<>><>>>><^^>vv>v<^^^>>v^v^<^^>v^^>v^<^v>v<>>v^v^<v>v^^<^^vv<
        <<v<^>>^^^^>>>v^<>vvv^><v<<<>^^^vv^<vvv>^>v<^^^^v<>^>vvvv><>>v^<<^^^^^
        ^><^><>>><>^^<<^^v>>><^<v>^<vv>>v>>>^v><>^v><<<<v>>v<v<v>vvv>^<><<>^><
        ^>><>^v<><^vvv<^^<><v<<<<<><^v<<<><<<^^<v<^^^><^>>^<v^><<<^>>^v<v^v<v^
        >^>>^v>vv>^<<^v<>><<><<v<<v><>v<^vv<<<>^^v^>^^>>><<^v>>v^v><^^>>^<>vv^
        <><^^>^^^<><vvvvv^v<v<<>^v<v>v<<^><<><<><<<^^<<<^<<>><<><^^^>^^<>^>v<>
        ^^>vv<^v^v<vv>^<><v<^v>^^^>>>^^vvv^>vvv<>>>^<^>>>>>^<<^v>^vvv<>^<><<v>
        v^^>>><<^^<>>^v^<v^vv<>v^<<>^<^v^v><^<<<><<^<v><v<>vv>>v><v^<vv<>v^<<^
      INPUT
    end

    specify "#gps_coordinates", part: 1 do
      expect(warehouse_woes.gps_coordinates).to eq(10_092)
    end

    context "with scaling" do
      subject(:warehouse_woes) { ScaledWarehouseWoes.new(input) }

      specify "#gps_coordinates", part: 2 do
        expect(warehouse_woes.gps_coordinates).to eq(9021)
      end
    end
  end

  specify "#gps_coordinates", part: 1 do
    expect(warehouse_woes.gps_coordinates).to eq(1_577_255)
  end

  context "with scaling" do
    subject(:warehouse_woes) { ScaledWarehouseWoes.new(input) }

    specify "#gps_coordinates", part: 2 do
      expect(warehouse_woes.gps_coordinates).to eq(1_597_035)
    end
  end
end
