require 'binary_search_tree'

def kth_largest(tree_node, k)
    bst = BinarySearchTree.new
    array = bst.in_order_traversal(tree_node).reverse
    bst.find(array[k - 1], tree_node)
end
