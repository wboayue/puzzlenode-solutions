require 'minitest/spec'
require 'minitest/autorun'

require "mocha/setup"

module TestHelper

  def sample_input_file
    File.join(File.dirname(__FILE__), 'data/sample-input.txt')    
  end

end