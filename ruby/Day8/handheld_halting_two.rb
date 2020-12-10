#!/usr/bin/env ruby

require 'set'

Instruction = Struct.new(:pc, :opcode, :arg)
instructions = []

code = STDIN.readlines.map(&:chomp)

code.each_with_index do |line, pc|
  opcode, arg = line.split
  instructions[pc] = Instruction.new(pc, opcode, arg.to_i)
end

def toggle_opcode(instructions, pc)
  return if instructions[pc].arg.zero?  # jmp 0 doesn't make sense

  instruction = instructions[pc]
  instruction.opcode = instruction.opcode == 'jmp' ? 'nop' : 'jmp'
end

def accumulate(instructions, pc = 0, acc = 0, visited = Set.new)
  return false if visited.include? pc

  visited << pc

  acc += instructions[pc].arg if instructions[pc].opcode == 'acc'

  next_pc_offset = instructions[pc].opcode == 'jmp' ? instructions[pc].arg : 1
  next_pc = pc + next_pc_offset

  return acc if next_pc == instructions.count
  return false if next_pc > instructions.count

  accumulate(instructions, next_pc, acc, visited)
end

acc = instructions.select { |i| %w[jmp nop].any? { |opcode| i.opcode == opcode } }.map do |instruction|
  toggle_opcode(instructions, instruction.pc)
  acc = accumulate(instructions)
  toggle_opcode(instructions, instruction.pc)
  acc
end.filter { |x| x != false }.first

puts "ACC: #{acc}"
