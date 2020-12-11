#!/usr/bin/env ruby

def find_first_invalid(data, prefix_len = 25)
  return nil if data.size < prefix_len + 1

  prefix = data[0, prefix_len]
  target = data[prefix_len]

  prefix_sums = prefix.uniq.each_with_index.map do |u, i|
    prefix[i + 1..-1].map do |v|
      u + v
    end
  end.flatten

  return target unless prefix_sums.include? target

  find_first_invalid(data[1..-1], prefix_len)
end

def find_contiguous_with_sum(values, target_sum)
  hashes = {}
  (1..values.count - 1).each do |i|
    hashes[i] = values[i] if values[i] + values[i - 1] <= target_sum
  end

  hashes.keys.each do |front|
    (front..values.count - 1).each do |back|
      slice = values[front..back]
      sum = slice.reduce(&:+)
      return slice if sum == target_sum
      break if sum > target_sum
    end
  end

end

values = STDIN.readlines.map(&:to_i)
first_invalid = find_first_invalid(values, 25)
contiguous_slice = find_contiguous_with_sum(values, first_invalid)
puts "Sum: #{contiguous_slice.max + contiguous_slice.min}"
