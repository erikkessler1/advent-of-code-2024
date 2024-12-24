# frozen_string_literal: true

class CrossedWires
  include NewlineInput

  def output
    gates = {}
    to_find = {}

    lines.each do |line|
      if line.include?(":")
        gate, value = line.split(": ")
        gates[gate] = value == "1"
      elsif line.include?("->")
        op_a, op, op_2, _, target = line.split
        to_find[target] = [op_a, op, op_2]
      end
    end

    until to_find.empty?
      to_find = to_find.reject do |target, operation|
        op_a, op, op_b = operation
        next false unless gates.include?(op_a) && gates.include?(op_b)

        op_a = gates[op_a]
        op_b = gates[op_b]

        case op
        when "AND"
          gates[target] = op_a && op_b
        when "OR"
          gates[target] = op_a || op_b
        when "XOR"
          gates[target] = op_a ^ op_b
        end

        true
      end
    end

    x_results = gates.sort.map do |k, v|
      next unless k.start_with?("x")

      v ? 1 : 0
    end.compact

    x = x_results.each_with_index.map { |v, i| v * (2**i) }.sum

    y_results = gates.sort.map do |k, v|
      next unless k.start_with?("y")

      v ? 1 : 0
    end.compact

    y = y_results.each_with_index.map { |v, i| v * (2**i) }.sum

    z_results = gates.sort.map do |k, v|
      next unless k.start_with?("z")

      v ? 1 : 0
    end.compact

    z = z_results.each_with_index.map { |v, i| v * (2**i) }.sum

    goal = x + y
    _goal_result = Array.new(z_results.size).each_with_index.map { |_, i| (goal / (2**i)) % 2 }

    z
  end

  # Found by looking bit-by-bit. There must be some automatic way to
  # do it but I don't care to find it at this point.
  def crossed
    ["fbq", "z36", "pvb", "z16", "qff", "qnw", "qqp", "z23"].sort.join("\n")
  end
end
