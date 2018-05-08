# There are many ways to implement these methods, feel free to add arguments 
# to methods as you see fit, or to create helper methods.
require 'bst_node'

class BinarySearchTree
  attr_reader :root

  def initialize
    @root = nil
  end

  def insert(value)
    if @root
      parent = @root
      child = parent.value > value ? parent.left : parent.right
      until child == nil
        parent = child
        child = parent.value > value ? parent.left : parent.right
      end
      if parent.value > value
        parent.left = BSTNode.new(value)
      else
        parent.right = BSTNode.new(value)
      end
    else
      @root = BSTNode.new(value)
    end
  end

  def find(value, tree_node = @root)
    return tree_node unless tree_node
    until tree_node == nil
      if tree_node.value == value
        return tree_node  
      elsif tree_node.value > value
        tree_node = tree_node.left
      else
        tree_node = tree_node.right
      end
    end
    nil
  end

  def find_parent(value, tree_node = @root)
    return nil if find(value, tree_node) == nil
    return nil if value == @root.value
    parent = tree_node
    child = tree_node.value > value ? tree_node.left : tree_node.right
    until child.value == value
      parent = child
      if child.value > value
        child = child.left
      else
        child = child.right
      end
    end

    parent
  end

  def delete(value)
    node_parent = find_parent(value)
    node_delete = find(value)
    return nil if node_delete == nil

    children = []
    children.push(node_delete.left) if node_delete.left
    children.push(node_delete.right) if node_delete.right

    if node_parent
      if children.length == 0 #no children
        if node_parent.value > value 
          node_parent.left = nil
        else
          node_parent.right = nil
        end
      elsif children.length == 1 #one child
        if node_parent.value > value
          node_parent.left = children.pop
        else
          node_parent.right = children.pop
        end
      else #two children need to find maximum to replace the value
        new_child = maximum(node_delete.left)
        new_child_parent = find_parent(new_child.value)
        new_child_parent.right = new_child.left
        new_child.left = node_delete.left
        new_child.right = node_delete.right
        if node_parent.value > value
          node_parent.left = new_child
        else
          node_parent.right = new_child
        end
      end
    else #deleting the root
      if children.length == 0
        @root = nil
      elsif children.length == 1
        @root = children.pop
      else
        new_child = maximum(node_delete.left)
        new_child_parent = find_parent(new_child.value)
        new_child_parent.right = new_child.left
        new_child.left = node_delete.left
        new_child.right = node_delete.right
        @root = new_child
      end
    end
    value
  end

  # helper method for #delete:
  def maximum(tree_node = @root)
    until tree_node.right == nil
      tree_node = tree_node.right
    end
    tree_node
  end

  def depth(tree_node = @root)
    return 0 if tree_node == nil
    return 0 if tree_node.left == nil && tree_node.right == nil
    left = depth(tree_node.left) 
    right = depth(tree_node.right) 
    if left > right
      return 1 + left
    else
      return 1 + right
    end
  end 
  
  def is_balanced?(tree_node = @root)
    return true if tree_node == nil
    return true if tree_node.left == nil && tree_node.right == nil
    left = depth(tree_node.left) 
    right = depth(tree_node.right) 
    if left == right
      true
    else
      false
    end
  end

  def in_order_traversal(tree_node = @root, arr = [])
    return arr if tree_node == nil
    return arr.push(tree_node.value) if tree_node.left == nil && tree_node.right == nil

    in_order_traversal(tree_node.left, arr)
    arr.push(tree_node.value)
    in_order_traversal(tree_node.right, arr)
    arr
  end


  private
  # optional helper methods go here:

end
