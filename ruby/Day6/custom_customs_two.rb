#!/usr/bin/env ruby

require 'set'

sum = STDIN.read.split("\n\n").map do |group|
  lines = group.split("\n")
  lines.first.chars.select { |char| char =~ /[a-z]/ }.select do |char|
    group.count(char) == lines.count
  end.to_set.count
end.reduce(&:+)

puts "Sum: #{sum}"
