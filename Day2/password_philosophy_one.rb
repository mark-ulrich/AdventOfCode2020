#!/usr/bin/env ruby

def count_valid_passwords(file)
  valid_count = 0
  file.readlines.map(&:chomp).each do |line|
    slack, password = line.split(': ')
    slack, pass_char = slack.split(' ')
    min, max = slack.split('-').map(&:to_i)
    pass_char_count = password.count(pass_char)
    valid_count += 1 unless pass_char_count < min || pass_char_count > max
  end
  valid_count
end

puts "Valid count: #{count_valid_passwords(STDIN)}"
