# There are many ways to implement these methods, feel free to add arguments
# to methods as you see fit, or to create helper methods.
require 'byebug'

class BinarySearchTree
  attr_accessor :root

  def initialize
    @root = nil
  end

  def insert(value)
    unless @root
      @root = BSTNode.new(value)
      return value
    end

    if value <= @root.value && @root.left.nil?
      @root.left = BSTNode.new(value)
      @root.left.parent = @root
      return value
    elsif value > @root.value && @root.right.nil?
      @root.right = BSTNode.new(value)
      @root.right.parent = @root
      return value
    end

    if value <= @root.value
      left_subtree = BinarySearchTree.new
      left_subtree.root = @root.left
      left_subtree.insert(value)
    elsif value > @root.value
      right_subtree = BinarySearchTree.new
      right_subtree.root = @root.right
      right_subtree.insert(value)
    end
  end

  def find(value, tree_node = @root)
    return tree_node if tree_node.value == value
    return nil if tree_node.left.nil? && tree_node.right.nil?

    if value <= tree_node.value
      left_subtree = BinarySearchTree.new
      left_subtree.root = tree_node.left
      left_subtree.find(value)
    elsif value > tree_node.value
      right_subtree = BinarySearchTree.new
      right_subtree.root = tree_node.right
      right_subtree.find(value)
    end
  end

  def delete(value)
    target_node = self.find(value)
    return nil unless target_node
    parent_left = target_node.parent.left == target_node unless target_node == @root

    if target_node.left.nil? && target_node.right.nil?
      if target_node == @root
        @root = nil
      elsif parent_left
        target_node.parent.left = nil
      else
        target_node.parent.right = nil
      end
    elsif target_node.left && target_node.right.nil?
      if parent_left
        target_node.parent.left = target_node.left
      else
        target_node.parent.right = target_node.left
      end
    elsif target_node.right && target_node.left.nil?
      if parent_left
        target_node.parent.left = target_node.right
      else
        target_node.parent.right = target_node.right
      end
    else
      max_left = self.maximum(target_node.left)

      if max_left.left.nil?
        if parent_left
          target_node.parent.left = max_left
          max_left.parent = target_node.parent
          max_left.left = target_node.left
          max_left.right = target_node.right
        else
          target_node.parent.right = max_left
          max_left.parent = target_node.parent
          max_left.left = target_node.left
          max_left.right = target_node.right
        end
      else
        if max_left.parent.left == max_left
          max_left.parent.left = max_left.left
        else
          max_left.parent.right = max_left.left
        end
        if parent_left
          target_node.parent.left = max_left
          max_left.parent = target_node.parent
          max_left.left = target_node.left
          max_left.right = target_node.right
        else
          target_node.parent.right = max_left
          max_left.parent = target_node.parent
          max_left.left = target_node.left
          max_left.right = target_node.right
        end
      end
    end
  end

  # helper method for #delete:
  def maximum(tree_node = @root)
    return tree_node if tree_node.right.nil?
    right_subtree = BinarySearchTree.new
    right_subtree.root = tree_node.right
    right_subtree.maximum
  end

  def depth(tree_node = @root)
    return 0 if no_children?(tree_node)
    return 1 if no_children?(tree_node.left) && tree_node.right.nil?
    return 1 if no_children?(tree_node.right) && tree_node.left.nil?
    return 1 if no_children?(tree_node.left) && no_children?(tree_node.right)

    left_subtree = BinarySearchTree.new
    left_subtree.root = tree_node.left
    right_subtree = BinarySearchTree.new
    right_subtree.root = tree_node.right

    left_subtree.depth > right_subtree.depth ? (return left_subtree.depth + 1) : (return right_subtree.depth + 1)
  end

  def is_balanced?(tree_node = @root)
    return true if no_children?(tree_node)

    left_subtree = BinarySearchTree.new
    left_subtree.root = tree_node.left
    right_subtree = BinarySearchTree.new
    right_subtree.root = tree_node.right

    if (left_subtree.depth - right_subtree.depth).abs <= 1
      if left_subtree.is_balanced? && right_subtree.is_balanced?
        return true
      else
        return false
      end
    else
      return false
    end

  end

  def in_order_traversal(tree_node = @root, arr = [])
    return arr unless tree_node
    return arr << tree_node.value if no_children?(tree_node)
    left_subtree = BinarySearchTree.new
    left_subtree.root = tree_node.left
    right_subtree = BinarySearchTree.new
    right_subtree.root = tree_node.right
    left_subtree.in_order_traversal + [tree_node.value] + right_subtree.in_order_traversal
  end

  

  private
  # optional helper methods go here:
  def no_children?(node)
    return true unless node
    node.left.nil? && node.right.nil?
  end

end
