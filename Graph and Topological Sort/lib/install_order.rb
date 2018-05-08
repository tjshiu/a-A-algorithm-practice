# Given an Array of tuples, where tuple[0] represents a package id,
# and tuple[1] represents its dependency, determine the order in which
# the packages should be installed. Only packages that have dependencies
# will be listed, but all packages from 1..max_id exist.

# N.B. this is how `npm` works.

# Import any files you need to

require 'graph'
require 'topological_sort'

def install_order(arr)
    max_id = arr.flatten.max
    vertices = []
    (1..max_id).each do |v|
        vertices.push(Vertex.new(v))
    end

    arr.each do |tuple|
        to = vertices.find {|el| el.value == tuple[0]}
        from = vertices.find {|el| el.value == tuple[1]}
        Edge.new(from, to)
    end

    sorted_vertices = topological_sort(vertices)
    sorted_vertices.map {|v| v.value}
end 
