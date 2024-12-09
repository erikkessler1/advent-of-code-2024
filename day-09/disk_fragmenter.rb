# frozen_string_literal: true

require "delegate"

class DiskFragmenter
  include NewlineInput

  class Space < ::SimpleDelegator
    def initialize(...)
      super
      @used = 0
    end

    attr_reader :used

    def use(amount)
      @used += amount
    end

    def left
      self - @used
    end
  end

  def filesystem_checksum
    i = 0
    ti = disk_map.size - 1
    pos = 0
    checksum = 0
    to_fill = 0
    fillable = disk_map[ti]

    until i >= ti
      if to_fill.zero?
        id = i / 2
        disk_map[i].times do
          checksum += id * pos
          pos += 1
        end

        to_fill = disk_map[i + 1]
        i += 2
      else
        filled = [to_fill, fillable].min
        id = ti / 2
        filled.times do
          checksum += id * pos
          pos += 1
        end

        to_fill -= filled
        fillable -= filled
        if fillable.zero?
          ti -= 2
          fillable = disk_map[ti]
        end
      end
    end

    id = ti / 2
    fillable.times do
      checksum += id * pos
      pos += 1
    end

    checksum
  end

  def filesystem_checksum_whole_files
    disk_map.each_with_index do |value, i|
      disk_map[i] = Space.new(value) if i.odd?
    end

    checksum = 0
    i = disk_map.size - 1
    while i.positive?
      id = i / 2
      to_move = disk_map[i]
      move_to = 1

      loop do
        break move_to = nil if move_to > i

        left = disk_map[move_to].left
        break if left >= to_move

        move_to += 2
      end

      if move_to
        value = disk_map[move_to]
        used = value.used
        value.use(to_move)

        pos = disk_map.take(move_to).sum
        pos += used

      else
        pos = disk_map.take(i).sum
      end

      to_move.times do
        checksum += id * pos
        pos += 1
      end

      i -= 2
    end

    checksum
  end

  private

  def disk_map
    @disk_map ||= lines.first.each_char.map(&:to_i)
  end
end
