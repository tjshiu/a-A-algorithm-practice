require_relative "static_array"

class RingBuffer
  attr_reader :length

  def initialize
    @store = StaticArray.new(8)
    @length = 0
    @capacity = 8
    @start_idx = 0
  end

  # O(1)
  def [](index)
    check_index(index)
    @store[(index + @start_idx) % @capacity]
  end
  
  # O(1)
  def []=(index, val)
    check_index(index)
    @store[(index + @start_idx) % @capacity] = val
  end

  # O(1)
  def pop
    raise "index out of bounds" if @length == 0
    temp = @store[(@length + @start_idx - 1) % @capacity] 
    @store[(@length + @start_idx - 1)  % @capacity] = nil
    @length -= 1
    temp
  end

  # O(1) ammortized
  def push(val)
    if @length == @capacity 
      resize!
    end
    @store[(@length + @start_idx)  % @capacity] = val
    @length += 1
    val
  end

  # O(1)
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

  # O(1) ammortized
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
  attr_accessor :capacity, :start_idx, :store
  attr_writer :length

  def check_index(index)
    raise 'index out of bounds' if index < 0 || index >= @length
  end

  def resize!
    temp = StaticArray.new(@capacity * 2)
    (0...@length).each do |idx|
      temp[idx] = @store[(idx + @start_idx) % capacity]
    end
    @store = temp
    @capacity *= 2
    @start_idx = 0
    @store
  end
end
