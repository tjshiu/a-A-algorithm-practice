class BSTNode
  attr_accessor :left, :right
  attr_reader :value

  def initialize(value, left = nil, right = nil)
    @value = value
    @left = left
    @right = right
  end
end

