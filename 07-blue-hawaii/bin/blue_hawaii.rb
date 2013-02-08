#!/usr/bin/env ruby

require 'trollop'
require 'blue_hawaii'

parser = Trollop::Parser.new do
  opt :input, "path input date range", required: true, type: :string
  opt :rentals, "path to rentals", required: true, type: :string
end

options = Trollop::with_standard_exception_handling parser do
  raise Trollop::HelpNeeded if ARGV.empty?
  parser.parse ARGV
end

unless File.exists? options[:input]
  puts "File containing date range #{options[:input]} does not exist."
  exit(1)
end

unless File.exists? options[:rentals]
  puts "Rentals file #{options[:rentals]} does not exist."
  exit(1)
end

blue_hawaii = BlueHawaii.new(input: options[:input], rentals: options[:rentals])
blue_hawaii.solve
