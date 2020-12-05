#!/usr/bin/env ruby

def count_valid_passwords(file)
  valid_count = 0
  file.readlines.map(&:chomp).each do |line|
    slack, password = line.split(': ')
    slack, pass_char = slack.split(' ')
    first, second = slack.split('-').map(&:to_i).map { |x| x - 1 }
    valid_count += 1 if password.chars.values_at(first, second).one?(pass_char)
  end
  valid_count
end

puts "Valid count: #{count_valid_passwords(STDIN)}"
