class SocialGraph
  
  def initialize
    @graph = {}
  end

  def users
    @graph.keys.sort
  end

  def connections(from)
     {}.tap do |results|
      connections = results[0] = @graph[from][:connections].sort

      visited = [from] + connections

      connections.each do |to|
        add_connections(results, 1, visited, to) unless leaf_node?(to, visited)
      end

      prune(results)
    end 
  end

  def add_interaction(user, connections = [])
    if @graph.has_key? user
      @graph[user][:prospects].concat connections
    else
      @graph[user] = {connections: [], prospects: connections}
    end

    connections.each do |target|
      if @graph.has_key?(target) && @graph[target][:prospects].include?(user)
        @graph[target][:prospects].delete(user)
        @graph[target][:connections].push(user)

        @graph[user][:prospects].delete(target)
        @graph[user][:connections].push(target)        
      end
    end
  end

  private

  def prune(results)
    visited = []

    results.keys.sort.each do |level|
      pruned = results[level] - visited
      visited.concat results[level]

      if pruned.empty?
        results.delete level
      else
        results[level] = pruned
      end
    end
  end

  def leaf_node?(to, visited)
    (@graph[to][:connections] - visited).empty?
  end

  def add_connections(results, level, visited, to)
    results[level] = [] if results[level].nil?

    world = @graph[to][:connections] + visited
    candidates = @graph[to][:connections] - visited

    results[level].concat(candidates).uniq!

    candidates.each do |connection|
      add_connections(results, level + 1, world, connection)  unless leaf_node?(to, visited)
    end
  end

end
