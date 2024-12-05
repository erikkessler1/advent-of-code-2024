# frozen_string_literal: true

class PrintQueue
  include NewlineInput

  def ordered_updates
    updates.select(&:valid?).map(&:middle).sum
  end

  def fixed_updates
    updates.select(&:invalid?).map(&:fix).map(&:middle).sum
  end

  private

  # Condense the rules into a table that says which pages *cannot*
  # come after a given page.
  def afters
    @afters ||= rules.each_with_object({}) do |(before, after), afters|
      afters[after] ||= []
      afters[after] << before
    end
  end

  def rules
    @rules ||= lines.map do |line|
      next unless line.include?("|")

      line.split("|").map(&:to_i)
    end.compact
  end

  def updates
    @updates ||= lines.map do |line|
      next unless line.include?(",")

      update = line.split(",").map(&:to_i)
      initialize_update(update)
    end.compact
  end

  # Who needs classes lol?
  def initialize_update(update)
    this_afters = afters
    this_initialize_update = method(:initialize_update)

    update.define_singleton_method(:middle) do
      self[size / 2]
    end

    update.define_singleton_method(:valid?) do
      result = true

      # Build a set of disallowed pages, and if we ever see one of
      # those disallowed pages, we know it is out of order.
      update.reduce(Set.new) do |disallowed, page|
        if disallowed.include?(page)
          result = false
          break
        end

        disallowed.merge(this_afters[page] || [])
      end

      result
    end

    update.define_singleton_method(:invalid?) do
      !valid?
    end

    update.define_singleton_method(:fix) do
      reduced = map do |page|
        [
          page,
          (this_afters[page] & self) || []
        ]
      end

      # I'm not sure this is _guaranteed_ to work, but sort the update
      # so that the pages with the smallest number of disallowed afters
      # go first in the fixed update.
      sorted = reduced.sort_by { |(_page, afters)| afters.size }

      fixed = sorted.map(&:first)
      this_initialize_update.call(fixed)
    end

    update
  end
end
