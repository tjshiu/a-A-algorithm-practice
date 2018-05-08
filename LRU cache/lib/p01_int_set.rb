class MaxIntSet
  def initialize(max)
    @store = Array.new(max, false)
  end

  def insert(num)
    raise "Out of bounds" if num > @store.length || num < 0
    unless include?(num)
      @store[num] = true
    end
  end
  
  def remove(num)
    raise "Out of bounds" if num > @store.length || num < 0
    if include?(num)
      @store[num] = false
    end
  end

  def include?(num)
    @store[num] 
  end

  private

  def is_valid?(num)
    if num > @max 
      return false
    end
    return true
  end

  def validate!(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    bucket = self[num]
    unless include?(num)
      @store[bucket].push(num)
    end
  end

  def remove(num)
    bucket = self[num]
    if include?(num)
      @store[bucket].delete(num)
    end
  end

  def include?(num)
    bucket = self[num]
    return true if @store[bucket].include?(num)
    false
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    num % num_buckets
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    resize! if @count == num_buckets
    bucket = self[num]
    unless include?(num)
      @store[bucket].push(num)
      @count += 1
    end
  end

  def remove(num)
    bucket = self[num]
    if include?(num)
      @store[bucket].delete(num)
      @count -= 1
    end
  end

  def include?(num)
    bucket = self[num]
    return true if @store[bucket].include?(num)
    false
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    i = num % num_buckets
  end

  def num_buckets
    @store.length
  end

  def resize!
    temp = Array.new(num_buckets * 2) { Array.new }
    @store.each do |array|
      array.each do |num|
        i = num % temp.length
        temp[i] << num
      end
    end
    @store = temp
  end
end
