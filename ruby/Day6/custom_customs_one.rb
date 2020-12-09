#!/usr/bin/env ruby

require 'set'

sum = STDIN.read.split("\n\n").map do |group|
  group.chars.select { |char| char =~ /[a-z]/ }.to_set.size
end.reduce(&:+)

puts "Sum: #{sum}"
