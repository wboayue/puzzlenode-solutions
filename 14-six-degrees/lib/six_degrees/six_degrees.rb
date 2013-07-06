require 'six_degrees/tweet_parser'
require 'six_degrees/social_graph'

class SixDegrees
  
  def solve(file_name)
    parser = TweetParser.new
    graph = SocialGraph.new

    results = {}

    File.new(file_name).each_line do |line|
      interaction = parser.parse(line)
      graph.add_interaction(*interaction)
    end

    graph.users.each do |user|
      results[user] = graph.connections(user)
    end

    results
  end

  def print(solution)
    solution.keys.each do |user|
      puts user

      network = solution[user]
      network.keys.each do |level|
        puts network[level].join ", "
      end

      puts
    end
  end

end