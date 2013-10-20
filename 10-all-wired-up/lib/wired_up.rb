require 'wired_up/node'
require 'wired_up/circuit'
require 'wired_up/text_graph'

module WiredUp
  def self.solve
    Circuit.solve File.join(File.dirname(__FILE__), '../spec/data/complex_circuits.txt')
  end
end
