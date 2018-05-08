class Node
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous node to next node
    # and removes self from list.
    prev_node = @prev
    next_node = @next
    prev_node.next = next_node if prev_node
    next_node.prev = prev_node if next_node
    @prev, @next = nil, nil
    self
  end
end

class LinkedList
  include Enumerable 

  def initialize
    @head = Node.new
    @tail = Node.new
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |node, j| return node if i == j }
    nil
  end

  def first
    empty? ? nil : @head.next
  end

  def last
    empty? ? nil : @tail.prev
  end

  def empty?
    @head.next == @tail && @tail.prev == @head
  end

  def get(key)
    each { |node| return node.val if node.key == key }
    nil
  end

  def include?(key)
    any? { |node| node.key == key}
  end

  def append(key, val)
    cur_end = @tail.prev
    new_end = Node.new(key, val)
    cur_end.next = new_end
    new_end.prev = cur_end
    new_end.next = @tail
    @tail.prev = new_end

    new_end
  end

  def update(key, val)
    child = @head.next
    until child == @tail
      if child.key == key
        child.val = val
        return child
      end
      child = child.next
    end
  end

  def remove(key)
    each do |node|
      if node.key == key
        node.remove
        return node.val
      end
    end
  end

  def each
    node = @head.next
    until node == @tail
      yield node
      node = node.next
    end
  end


  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, node| acc << "[#{node.key}, #{node.val}]" }.join(", ")
  end
end
