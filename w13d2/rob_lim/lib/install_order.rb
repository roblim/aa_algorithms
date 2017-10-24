# Given an Array of tuples, where tuple[0] represents a package id,
# and tuple[1] represents its dependency, determine the order in which
# the packages should be installed. Only packages that have dependencies
# will be listed, but all packages from 1..max_id exist.

# N.B. this is how `npm` works.

# Import any files you need to

require_relative 'topological_sort'
require_relative 'graph'

def install_order(arr)
  vertices = {}

  arr.flatten.uniq.each { |id| vertices[id] = Vertex.new(id) }
  arr.each do |tuple|
    Edge.new(vertices[tuple[1]], vertices[tuple[0]])
  end

  no_dep = (1..arr.flatten.max).to_a.reject { |el| arr.flatten.include?(el) }
  result = topological_sort(vertices.values)
  no_dep.each { |id| result << Vertex.new(id) }
  result.map(&:value)
end
