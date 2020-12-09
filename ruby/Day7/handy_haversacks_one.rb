#!/usr/bin/env ruby

require 'set'

Bag = Struct.new(:type, :found_in)
bags = {}

def count_possible_containers(bag, valid_bags = Set.new)
  bag.found_in.each do |nested_bag|
    valid_bags << nested_bag.type
    count_possible_containers(nested_bag, valid_bags)
  end
  valid_bags.count
end

purge_junk = proc do |line|
  line.chomp.gsub(/ bag[s]{0,1}/, '').gsub(/ no other/, '').gsub(/\./, '')
end

STDIN.readlines.map(&purge_junk).each do |line|
  bag_type, contains = line.split(' contain ')
  bags[bag_type] = Bag.new(bag_type, []) if bags[bag_type].nil?

  next if contains.nil?

  contains.split(', ').map { |c| c[2..-1] }.each do |containee|
    bags[containee] = Bag.new(containee, [bags[bag_type]]) if bags[containee].nil?
    bags[containee].found_in << bags[bag_type]
  end
end

puts "Count: #{count_possible_containers(bags['shiny gold'])}"
