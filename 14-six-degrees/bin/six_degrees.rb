#!/usr/bin/env ruby

require 'trollop'
require 'six_degrees'

parser = Trollop::Parser.new do
  opt :input, "path to data file", required: true, type: :string
end

options = Trollop::with_standard_exception_handling parser do
  raise Trollop::HelpNeeded if ARGV.empty?
  parser.parse ARGV
end

unless File.exists? options[:input]
  puts "Data file #{options[:input]} does not exist."
  exit(1)
end

puzzle = SixDegrees.new
solution = puzzle.solve(options[:input])

puts puzzle.print(solution)