#!/usr/bin/env ruby

required_fields = %w[byr iyr eyr hgt hcl ecl pid]
valid_eye_colors = %w[amb blu brn gry grn hzl oth]

valid_count = 0
STDIN.read.split("\n\n").each do |line|
  next unless required_fields.all? { |field| line.include?(field) }

  fields = {}

  line.sub("\n", ' ').split(' ').each do |field|
    key, value = field.split(':')
    fields[key] = value
  end

  next unless fields['byr'].to_i.between?(1920, 2002)
  next unless fields['iyr'].to_i.between?(2010, 2020)
  next unless fields['eyr'].to_i.between?(2020, 2030)
  next unless fields['hcl'] =~ /^#[0-9a-f]{6}$/
  next unless valid_eye_colors.one? { |color| fields['ecl'] == color }
  next unless fields['pid'] =~ /^[0-9]{9}$/

  if fields['hgt'].include?('cm')
    next unless fields['hgt'][0, 3].to_i.between?(150, 193)
  elsif fields['hgt'].include?('in')
    next unless fields['hgt'][0, 2].to_i.between?(59, 76)
  else
    next
  end

  valid_count += 1
end

puts "Valid: #{valid_count}"
