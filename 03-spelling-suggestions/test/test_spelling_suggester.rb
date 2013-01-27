require_relative 'test_helper'

require 'spelling_suggester'

describe SpellingSuggester do
  
  describe "#lcs" do
    before do
      @suggester = SpellingSuggester.new
    end

    it "should find lcs" do
      assert_equal "remmance", @suggester.lcs("remimance", "remembrance")
      assert_equal "remince", @suggester.lcs("remimance", "reminiscence")

      assert_equal "idiely", @suggester.lcs("immediately", "inndietlly")
      assert_equal "indetlly", @suggester.lcs("incidentally", "inndietlly")
    end
  end

end
