require_relative 'test_helper'

require 'spelling_suggester'

describe SpellingSuggester do
  
  include TestHelper

  describe "#lcs_len" do
    before do
      @suggester = SpellingSuggester.new sample_tuples
    end

    it "should find lcs_len" do
      assert_equal 8, @suggester.lcs_len("remimance", "remembrance")
      assert_equal 7, @suggester.lcs_len("remimance", "reminiscence")

      assert_equal 6, @suggester.lcs_len("immediately", "inndietlly")
      assert_equal 8, @suggester.lcs_len("incidentally", "inndietlly")
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
