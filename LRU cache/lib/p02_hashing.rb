class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    h = 0
    self.each_with_index do |el, idx|
      h += el.hash * idx.hash
    end
    h
  end
end

class String
  def hash
    h = 0
    self.chars.each_with_index do |ch, idx|
      h += ch.ord.hash * idx.hash
    end
    h
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    h = 0
    self.keys.each do |k|
      h += k.hash * self[k].hash
    end
    h
  end
end
