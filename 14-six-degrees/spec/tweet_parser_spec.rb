require 'six_degrees'

describe TweetParser do
  
  describe "#parse" do
    before do
      @parser = TweetParser.new
    end

    it "should extract user and connections" do
      tweet = "bob: @duncan, @christie so I see it is Emerson tonight"

      user, connections = @parser.parse tweet
      
      user.should == 'bob'
      connections.should == ['duncan', 'christie']
    end

  end

end