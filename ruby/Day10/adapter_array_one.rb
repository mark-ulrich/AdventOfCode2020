#!/usr/bin/env ruby

adapters = STDIN.readlines.map(&:to_i).sort

distribution = Hash.new(0)
adapters.each_with_index do |adapter, i|
  prev_adapter = i.positive? ? adapters[i - 1] : 0
  distribution[adapter - prev_adapter] += 1
end
distribution[3] += 1

puts "Product: #{distribution[1] * distribution[3]}"
