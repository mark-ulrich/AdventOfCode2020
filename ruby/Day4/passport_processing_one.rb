#!/usr/bin/env ruby

required_fields = %w[
  byr
  iyr
  eyr
  hgt
  hcl
  ecl
  pid
]
valid_count = 0
STDIN.read.split("\n\n").each do |line|
  valid_count += 1 if required_fields.all? { |field| line.include?(field) }
end

puts "Valid: #{valid_count}"
