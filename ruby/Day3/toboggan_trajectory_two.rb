#!/usr/bin/env ruby

tree_count = 0
STDIN.readlines.map(&:chomp).each_with_index do |line, i|
  offset = (i * 3) % line.size
  tree_count += 1 if line[offset] == '#'
end

puts "Tree count: #{tree_count}"
