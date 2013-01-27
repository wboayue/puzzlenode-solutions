require_relative 'test_helper'

require 'spelling_suggester'

describe SpellingSuggester do
  
  include TestHelper

  describe "#lcs" do
    before do
      @suggester = SpellingSuggester.new sample_tuples
    end

    it "should find lcs" do
      assert_equal "remmance", @suggester.lcs("remimance", "remembrance")
      assert_equal "remince", @suggester.lcs("remimance", "reminiscence")

      assert_equal "idiely", @suggester.lcs("immediately", "inndietlly")
      assert_equal "indetlly", @suggester.lcs("incidentally", "inndietlly")
    end
  end

  describe "#each_tuples" do
    before do
      @suggester = SpellingSuggester.new sample_tuples
    end

    it "should enumerate each tuple" do
      expected_tuples = [
        %w(remimance remembrance reminiscence),
        %w(inndietlly immediately incidentally)
      ]

      actual_tuples = []

      @suggester.each_tuple do |tuple|
        actual_tuples.push(tuple)
      end

      assert_equal expected_tuples, actual_tuples
    end
  end

end
