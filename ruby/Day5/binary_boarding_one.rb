#!/usr/bin/env ruby

Rows = (0..(2**7)).to_a.freeze
Columns = (0..(2**3)).to_a.freeze

def generate_seat_id(chars, rows, columns)
  return rows.first * 8 + columns.first if chars.empty?

  case chars.shift
  when 'F'
    generate_seat_id(chars, rows[0, rows.size / 2], columns)
  when 'B'
    generate_seat_id(chars, rows[rows.size / 2..-1], columns)
  when 'L'
    generate_seat_id(chars, rows, columns[0, columns.size / 2])
  when 'R'
    generate_seat_id(chars, rows, columns[columns.size / 2..-1])
  end
end

found_seat_ids = []
STDIN.readlines.map(&:chomp).each do |line|
  found_seat_ids.push(generate_seat_id(line.chars, Rows, Columns))
end

puts "Highest: #{found_seat_ids.max}"
