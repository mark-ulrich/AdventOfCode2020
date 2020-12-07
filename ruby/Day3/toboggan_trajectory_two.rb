#!/usr/bin/env ruby

counts = Array.new(5, 0)
STDIN.readlines.map(&:chomp).each_with_index do |line, i|
  counts[0] += 1 if line[i % line.size] == '#'
  counts[1] += 1 if line[(i * 3) % line.size] == '#'
  counts[2] += 1 if line[(i * 5) % line.size] == '#'
  counts[3] += 1 if line[(i * 7) % line.size] == '#'
  counts[4] += 1 if i.even? && line[(i / 2) % line.size] == '#'
end

product = counts.reduce do |prod, val|
  prod *= val
  prod
end
puts "Product: #{product}"
