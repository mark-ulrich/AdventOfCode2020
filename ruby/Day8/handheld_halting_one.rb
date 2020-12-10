#!/usr/bin/env ruby

require 'set'

class CPU
  attr_reader :acc

  def initialize(code)
    @pc = 0
    @acc = 0
    @code = code
    @visited = Set.new
    @running = false
  end

  def run
    @running = true
    while @running
      raise 'hell' if @visited.include? @pc

      @visited << @pc
      execute
      @pc += 1
    end
  end

  def execute
    opcode, arg = @code[@pc].split
    arg = arg.to_i

    case opcode
    when 'acc'
      @acc += arg
    when 'jmp'
      @pc += arg - 1
    end
  end
end

begin
  cpu = CPU.new(STDIN.readlines.map(&:chomp))
  cpu.run
rescue StandardError
  puts "ACC: #{cpu.acc}"
end
