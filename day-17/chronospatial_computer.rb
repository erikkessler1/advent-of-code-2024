# frozen_string_literal: true

class ChronospatialComputer
  include NewlineInput

  OPCODES = {
    0 => :adv,
    1 => :bxl,
    2 => :bst,
    3 => :jnz,
    4 => :bxc,
    5 => :out,
    6 => :bdv,
    7 => :cdv
  }.freeze

  def initialize(...)
    super

    @output = []
    @ip = 0
    @ra = lines[0].split(": ").last.to_i
    @rb = lines[1].split(": ").last.to_i
    @rc = lines[2].split(": ").last.to_i
    @program = lines[4][9..].split(",").map(&:to_i)
  end

  attr_reader :program, :output

  # bst a : a % 8 -> b
  # bxl 5 : b ^ 5 -> b
  # cdv b : a / 2**b -> c
  # adv 3 : a / 2**3 -> a
  # bxc 0 : b ^ c -> b
  # bxl 6 : b ^ 6 -> b
  # out b : b % 8
  # jnz 0 : a == 0
  #
  # We can build the result 3 bits at a time.
  def find_initial_a(desired_output = program.reverse, current = 0, found = [])
    return found << current if desired_output.empty?

    desired_digit = desired_output.first
    8.times do |i|
      a = (current << 3) + i
      result = override_run(a)
      find_initial_a(desired_output.drop(1), a, found) if result.first == desired_digit
    end

    found.min
  end

  def override_run(ora)
    @output = []
    @ip = 0
    @ra = ora
    @rb = 0
    @rc = 0

    run
  end

  def run
    until ip >= program.size
      opcode = program[ip]
      operand = program[ip + 1]
      operation = OPCODES.fetch(opcode)
      send(operation, operand)

      self.ip += 2 unless opcode == 3
    end

    output
  end

  private

  attr_accessor :ip,
                :ra, :rb, :rc

  def adv(operand)
    operand = combo_operand(operand)
    self.ra = ra / (2**operand)
  end

  def bxl(operand)
    self.rb = rb ^ operand
  end

  def bst(operand)
    operand = combo_operand(operand)
    self.rb = operand % 8
  end

  def out(operand)
    operand = combo_operand(operand)
    @output << (operand % 8)
  end

  def jnz(operand)
    return self.ip += 2 if ra.zero?

    self.ip = operand
  end

  def bxc(_operand)
    self.rb = rb ^ rc
  end

  def bdv(operand)
    operand = combo_operand(operand)
    self.rb = ra / (2**operand)
  end

  def cdv(operand)
    operand = combo_operand(operand)
    self.rc = ra / (2**operand)
  end

  def combo_operand(operand)
    case operand
    when 0, 1, 2, 3
      operand
    when 4
      ra
    when 5
      rb
    when 6
      rc
    when 7
      raise ArgumentError.new("7 not valid")
    end
  end
end
