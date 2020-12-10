#!/usr/bin/env ruby

Bag = Struct.new(:type, :containees)
bags = {}

purge_junk = proc do |line|
  [/ bag[s]{0,1}/, /\.$/].map { |pattern| line.gsub!(pattern, '') }
  line.chomp
end

STDIN.readlines.map(&purge_junk).each do |line|
  bag_type, contains = line.split(/ contain\s?/)
  bags[bag_type] = Bag.new(bag_type, []) if bags[bag_type].nil?

  next if contains.include? 'no other'

  contains.split(', ').each do |containee|
    number, containee = containee.split(' ', 2)
    bags[containee] = Bag.new(containee, []) if bags[containee].nil?
    bags[bag_type].containees << {
      'bag' => bags[containee],
      'number' => number.to_i
    }
  end
end

def count_total_bags(bag)
  total_bags = bag.containees.map { |x| x['number'] }.reduce(&:+) || 0
  return total_bags if bag.containees.empty?

  total_bags + bag.containees.map do |containee|
    containee['number'] * count_total_bags(containee['bag'])
  end.reduce(&:+)
end

puts "Count: #{count_total_bags(bags['shiny gold'])}"
