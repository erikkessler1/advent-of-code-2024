# frozen_string_literal: true

class MullItOver
  include NewlineInput

  MUL_INSTRUCTION = /mul\((\d{1,3}),(\d{1,3})\)/
  DO_INSTRUCTION = "do()"
  DO_NOT_INSTRUCTION = "don't()"

  def mul
    instructions = memory.scan(MUL_INSTRUCTION)
    products = instructions.map { _1.map(&:to_i).reduce(&:*) }
    products.sum
  end

  def conditional_mul
    enabled = true
    buffer = ""
    sum = 0

    memory.each_char do |char|
      buffer += char

      if buffer == DO_INSTRUCTION
        enabled = true
        buffer = ""
      elsif buffer == DO_NOT_INSTRUCTION
        enabled = false
        buffer = ""
      elsif buffer.match?(/^#{MUL_INSTRUCTION}$/)
        if enabled
          value = buffer.match(MUL_INSTRUCTION).to_a.drop(1).map(&:to_i).reduce(:*)
          sum += value
        end
        buffer = ""
      elsif DO_INSTRUCTION.start_with?(buffer)
        # Continue: building "do"
      elsif DO_NOT_INSTRUCTION.start_with?(buffer)
      # Continue: building "don't"
      elsif buffer.match?(/^m$/) ||
            buffer.match?(/^mu$/) ||
            buffer.match?(/^mul$/) ||
            buffer.match?(/^mul\($/) ||
            buffer.match?(/^mul\(\d{1,3}$/) ||
            buffer.match?(/^mul\(\d{1,3},$/) ||
            buffer.match?(/^mul\(\d{1,3},\d{1,3}$/)
        # Continue: building "mul"
      else
        buffer = ""
      end
    end

    sum
  end

  private

  def memory
    lines.join
  end
end
