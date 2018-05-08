require_relative "heap"

class Array
  def heap_sort!
    prc = Proc.new { |num1, num2| num2 <=> num1 }
    heap = BinaryMinHeap.new(&prc) 

    self.each do |el|
      heap.push(el)
    end
    
    while heap.count > 0
      el = heap.extract
      idx = heap.count
      self[idx] = el
    end
    self
  end
end
