# This class just dumbs down a regular Array to be statically sized.
class StaticArray
  def initialize(length)
    @length = length
    @store = Array.new(length)
  end

  # O(1)
  def [](index)
    raise 'index out of bounds' unless @store[index]
    @store[index]
  end

  # O(1)
  def []=(index, value)
    raise "index out of bounds" if index < 0 || index > @length
    @store[index] = value
    value
  end

  protected
  attr_reader :length
  attr_accessor :store
end
