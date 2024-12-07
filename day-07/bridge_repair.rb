# frozen_string_literal: true

class Integer
  def concat(other)
    shift = 10**Math.log10(other + 1).ceil
    (self * shift) + other
  end
end

class BridgeRepair
  include NewlineInput

  def calibration_result(operators: [:*, :+])
    lines.map do |line|
      equation = line.sub(":", "").split.map(&:to_i)
      target = equation.first
      operands = equation.drop(1)
      result = operands.first
      operands = operands.drop(1)

      valid?(target, result, operands, operators) ? target : 0
    end.sum
  end

  def real_calibration_result
    calibration_result(operators: [:*, :+, :concat])
  end

  private

  def valid?(target, result, operands, operators)
    return result == target if operands.empty?
    return false if result > target

    value = operands.first
    operands = operands.drop(1)

    operators.any? do |operator|
      next_result = result.send(operator, value)
      valid?(target, next_result, operands, operators)
    end
  end
end
