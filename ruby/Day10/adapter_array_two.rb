#!/usr/bin/env ruby

# Build a tree with a '0' root. Recursively add children to each node for
# adapters which are valid (1-3 more joltage). Count the terminating nodes in
# the tree to determine total number of valid combinations.
# NOTE: Using memoization to complete in this universe's lifetime.

Node = Struct.new(:joltage, :children)

def build_tree(adapters, memo = {})
  adapter = adapters[0]
  return memo[adapter] if memo.include? adapter

  node = Node.new(adapter, [])
  adapters.select { |a| a > node.joltage && a <= node.joltage + 3 }.each_with_index do |a, i|
    memo[a] = build_tree(adapters[i + 1..-1], memo)
    node.children << memo[a]
  end
  node
end

def count_paths(node, memo = {})
  return memo[node.joltage] unless memo[node.joltage].nil?
  return 1 if node.children.empty?

  count = node.children.map { |child| count_paths(child, memo) }.sum
  memo[node.joltage] = count
  count
end

puts '[+] Reading adapters...'
adapters = STDIN.readlines.map(&:to_i).sort
adapters.unshift(0)
adapters << adapters.max + 3
puts '[+] Building tree...'
tree = build_tree(adapters)
puts '[+] Counting paths...'
count = count_paths(tree)
puts "Combinations: #{count}"
