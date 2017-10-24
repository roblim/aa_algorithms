require_relative 'binary_search_tree'

def kth_largest(tree_node, k)
  b_tree = BinarySearchTree.new
  b_tree.root = tree_node
  b_tree.find(b_tree.in_order_traversal[-k])
end
