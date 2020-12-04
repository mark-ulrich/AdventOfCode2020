#!/usr/bin/env ruby

# Find the product of two values in input whose sum is 2020. Loop through input,
# storing the complement of the current value in a set. If the complement is
# already present in the set, we've found our targets.

require 'set'

target = 2020
complements = Set[]

values = STDIN.read.split.map(&:to_i)
values.each do |value|
  complement = target - value
  if complements.include?(value)
    puts "found: #{complement} * #{value} = #{value*(target-value)}"
    break
  else
    complements << complement
  end
end

