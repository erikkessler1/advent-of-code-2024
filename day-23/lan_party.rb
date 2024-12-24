# frozen_string_literal: true

class LanParty
  include NewlineInput

  def connected
    connections = Hash.new { |h, k| h[k] = [] }

    lines.each do |line|
      a, b = line.split("-")
      connections[a] << b
      connections[b] << a
    end

    results = []
    connections.each do |source, targets|
      next unless source.start_with?("t")

      perms = targets.permutation(2)

      perms.each do |a, b|
        next unless connections[a].include?(b)

        results << [source, a, b].sort
      end
    end

    results.uniq
  end

  def max_connected
    connections = Hash.new { |h, k| h[k] = [] }

    lines.each do |line|
      a, b = line.split("-")
      connections[a] << b
      connections[b] << a
    end

    results = []
    connections.each do |source, targets|
      next unless source.start_with?("t")

      (2..targets.size).each do |size|
        combos = targets.combination(size)
        combos.each do |combo|
          valid = combo.each_with_index.all? do |a, i|
            combo.each_with_index.all? do |b, j|
              next true if j <= i

              connections[a].include?(b)
            end
          end

          results << ([source] + combo).sort if valid
        end
      end
    end

    results.max_by(&:size)
  end
end
