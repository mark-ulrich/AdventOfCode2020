#!/usr/bin/env ruby

def find_invalid(data, prefix_len = 25)
  return nil if data.size < prefix_len + 1

  prefix = data[0, prefix_len]
  target = data[prefix_len]

  prefix_sums = prefix.uniq.each_with_index.map do |u, i|
    prefix[i + 1..-1].map do |v|
      u + v
    end
  end.flatten

  return target unless prefix_sums.include? target

  find_invalid(data[1..-1], prefix_len)
end

values = STDIN.readlines.map(&:to_i)
puts "First invalid: #{find_invalid(values)}"
