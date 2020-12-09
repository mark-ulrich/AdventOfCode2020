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

seen_seats = STDIN.readlines.map(&:chomp).map do |line|
  generate_seat_id(line.chars, Rows, Columns)
end

my_seat_id = (seen_seats.min..seen_seats.max).select do |value|
  !seen_seats.include?(value) && [value - 1, value + 1].all? do |v|
    seen_seats.include?(v)
  end
end.first

puts "My seat ID: #{my_seat_id}"
