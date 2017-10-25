require_relative 'graph'
require 'byebug'
# Implementing topological sort using both Khan's and Tarian's algorithms

# def topological_sort(vertices)
#   in_edge_counts = {}
#   queue = []
#
#   vertices.each do |v|
#     in_edge_counts[v] = v.in_edges.count
#     queue << v if v.in_edges.empty?
#   end
#
#   sorted_vertices = []
#
#   until queue.empty?
#     vertex = queue.shift
#     sorted_vertices << vertex
#     vertices.delete(vertex)
#     vertex.out_edges.each do |e|
#       to_vertex = e.to_vertex
#
#       in_edge_counts[to_vertex] -= 1
#       queue << to_vertex if in_edge_counts[to_vertex] == 0
#     end
#   end
#
#   vertices.empty? ? sorted_vertices : []
# end

def topological_sort(vertices)
  result = []
  visited = {}
  failure = nil
  cycle = []

  return [] if vertices.all? { |vertex| vertex.in_edges.length > 0 }

  until vertices.length == visited.keys.length
    vertices.each do |vertex|
      cycle = []
      check = traverse(vertex, visited, result, cycle)
      if check == []
        failure = true
        break
      end
    end
  end
  return [] if failure
  result
end

def traverse(vertex, visited, result, cycle)
  if visited[vertex].nil?
    return [] if cycle.include?(vertex)
    cycle << vertex
    neighbors = []
    vertex.out_edges.each do |edge|
      neighbors << edge.to_vertex
    end
    neighbors.each do |neighbor|
      traverse(neighbor, visited, result, cycle)
    end
    visited[vertex] = true
    result.unshift(vertex)
  end
end
