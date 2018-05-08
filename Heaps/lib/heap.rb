class BinaryMinHeap
  attr_reader :store, :prc

  def initialize(&prc)
    @store = []
    @prc = prc
  end

  def count
    @store.length
  end

  def extract
    @store[0], @store[count - 1] = @store[count - 1], @store[0] 
    val = @store.pop
    BinaryMinHeap.heapify_down(@store, 0, count, &@prc) 
    val
  end

  def peek
    @store[0]
  end

  def push(val)
    @store.push(val)
    BinaryMinHeap.heapify_up(@store, count - 1, count, &@prc)
  end

  public
  def self.child_indices(len, parent_index)
    result = []
    left_child = parent_index * 2 + 1
    right_child = parent_index * 2 + 2

    result.push(left_child) if left_child < len
    result.push(right_child) if right_child < len
    result
  end

  def self.parent_index(child_index)
    raise "root has no parent" if child_index == 0
    (child_index - 1 ) / 2
  end
  
  def self.heapify_down(array, parent_idx, len = array.length, &prc)
    sorted = false
    prc = prc ||= Proc.new { |num1, num2| num1 <=> num2 }
    until sorted == true
      sorted = true
      parent_val = array[parent_idx]
      children_idx = self.child_indices(len, parent_idx)
      break if children_idx.length == 0
      break if parent_idx > len - 1
      if children_idx.length == 2
        child1_val = array[children_idx[0]]
        child2_val = array[children_idx[1]] 
        child_idx = prc.call(child1_val, child2_val) == -1 ? children_idx[0] : children_idx[1]
        child_val = prc.call(child1_val, child2_val) == -1 ? child1_val : child2_val
      else
        child_idx = children_idx.first
        child_val = array[children_idx[0]]
      end
      if prc.call(parent_val, child_val) == 1
        array[child_idx], array[parent_idx] = array[parent_idx], array[child_idx]
        parent_val = child_val
        parent_idx = child_idx
        sorted = false
      end
    end
    array
  end
  
  def self.heapify_up(array, child_idx, len = array.length, &prc)
    sorted = false
    prc = prc ||= Proc.new { |num1, num2| num1 <=> num2 }
    until sorted == true
      sorted = true
      break if child_idx == 0
      child_val = array[child_idx]
      if (child_idx - 1 ) / 2 == 0
        parent_val = array[0]
        parent_idx = 0
      else 
        parent_idx = self.parent_index(child_idx)
        parent_val = array[parent_idx]
      end
      if prc.call(child_val, parent_val) == -1
        sorted = false
        array[child_idx], array[parent_idx] = array[parent_idx], array[child_idx]
        child_idx = parent_idx
      end
    end
    array
  end
end
