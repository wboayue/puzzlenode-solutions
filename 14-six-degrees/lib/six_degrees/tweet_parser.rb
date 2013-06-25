class TweetParser

  def parse(tweet)
    user = tweet[/^(.*?)\:/, 1]

    connections = tweet.scan(/@([a-zA-Z_]+)/).flatten

    [user, connections]
  end

end
