require_relative "static_array"

class DynamicArray
  attr_reader :length

  def initialize
    @store = StaticArray.new(8)
    @length = 0
    @capacity = 8
  end

  # O(1)
  def [](index)
    @store[index]
  end

  # O(1)
  def []=(index, value)
    @store[index] = value
  end

  # O(1)
  def pop
    raise "index out of bounds" if @length == 0
    @store[@length] = nil
    @length = @length - 1
    @store[@length]
  end
  
  # O(1) ammortized; O(n) worst case. Variable because of the possible
  # resize.
  def push(val)
    if @length == @capacity 
      resize!
    end
    @store[@length] = val
    @length = @length + 1
    val
  end
  
  # O(n): has to shift over all the elements.
  def shift
    raise "index out of bounds" if @length == 0
    first = @store[0]
    (0...@length).each do |idx|
      @store[idx] = nil if idx == @length - 1
      @store[idx] = @store[idx + 1] unless idx == @length - 1
    end
    @length = @length - 1
    first
  end

  # O(n): has to shift over all the elements.
  def unshift(val)
    if @length == @capacity 
      resize!
    end
    @length = @length + 1
    count = @length - 1
    while count > 0
      @store[count] = @store[count - 1]
      count -= 1
    end
    @store[0] = val
    val
  end

  protected
  attr_accessor :capacity, :store
  attr_writer :length

  def check_index(index)
    @store[index]
  end

  # O(n): has to copy over all the elements to the new store.
  def resize!
    temp = StaticArray.new(@capacity * 2)
    (0...@length).each do |idx|
      temp[idx] = @store[idx]
    end
    @store = temp
    @capacity *= 2
    @store
  end
end
