class TweetParser

  def parse(tweet)
    return extract_user(tweet), extract_connections(tweet)
  end

  private 

  def extract_user(tweet)
    tweet[/^(.*?)\:/, 1]
  end

  def extract_connections(tweet)
    tweet.scan(/@([a-zA-Z_]+)/).flatten
  end

end
