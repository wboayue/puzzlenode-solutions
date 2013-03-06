#!/usr/bin/env ruby

require 'trollop'
require 'turtle_tracks'

parser = Trollop::Parser.new do
  opt :input, "path to logo file", required: true, type: :string
end

options = Trollop::with_standard_exception_handling parser do
  raise Trollop::HelpNeeded if ARGV.empty?
  parser.parse ARGV
end

unless File.exists? options[:input]
  puts "Logo file #{options[:input]} does not exist."
  exit(1)
end

tracks = TurtleTracks.new options[:input]
tracks.process
puts tracks.print