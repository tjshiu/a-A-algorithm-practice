require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    resize! if @count == num_buckets
    bucket = self[key]
    unless include?(key)
      @store[bucket].push(key)
      @count += 1
    end
  end

  def include?(key)
    bucket = self[key]
    return true if @store[bucket].include?(key)
    false
  end

  def remove(key)
    bucket = self[key]
    if include?(key)
      @store[bucket].delete(key)
      @count -= 1
    end
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    num.hash % num_buckets
  end

  def num_buckets
    @store.length
  end

  def resize!
    temp = Array.new(num_buckets * 2) { Array.new }
    @store.each do |array|
      array.each do |num|
        i = num.hash % temp.length
        temp[i] << num
      end
    end
    @store = temp
  end
end
