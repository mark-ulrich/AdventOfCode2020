#!/usr/bin/env ruby

# Find the product of three values whose sum is 2020 in input.

def ProductOfThreeWithSum(values, sum) 
  complements = {}
  for i in 0..values.length 
    outerValue = values[i]
    values[i..].each do |innerValue|
      complement = sum - innerValue
      if complements.include?(complement) 
        return complements[complement].reduce() { |product, val|
          product * val
        } * innerValue
      else 
        complements[outerValue + innerValue] = [outerValue, innerValue]
      end   # I
    end     # hate
  end       # deep
end         # nests

values = STDIN.read.split.map(&:to_i)
puts ProductOfThreeWithSum(values, 2020)
# puts product