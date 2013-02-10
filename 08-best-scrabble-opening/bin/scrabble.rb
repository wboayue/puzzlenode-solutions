#!/usr/bin/env ruby

require 'trollop'
require 'scrabble'

parser = Trollop::Parser.new do
  opt :input, "path to scrabble puzzle input", required: true, type: :string
end

options = Trollop::with_standard_exception_handling parser do
  raise Trollop::HelpNeeded if ARGV.empty?
  parser.parse ARGV
end

unless File.exists? options[:input]
  puts "File containing date range #{options[:input]} does not exist."
  exit(1)
end

scrabble = Scrabble.new()
results = scrabble.best_opening options[:input]
results.each do |row|
  puts row
end