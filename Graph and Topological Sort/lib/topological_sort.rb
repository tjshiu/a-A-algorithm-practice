require_relative 'graph'

# Implementing topological sort using both Khan's and Tarian's algorithms

def topological_sort(vertices)
    sorted = []
    top = Queue.new
    vertices.each do |vertex|
        if vertex.in_edges.empty? 
            top.enq(vertex)
        end
    end

    until top.empty?
        current = top.pop
        sorted << current
        while current.out_edges.length != 0
            edge = current.out_edges[0]
            if edge.to_vertex.in_edges == [edge]
                top.enq(edge.to_vertex)
            end
            edge.destroy!
        end

    end

    if sorted.length != vertices.length
        return []
    end

    sorted
end
