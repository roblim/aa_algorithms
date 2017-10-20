require 'byebug'

class BinaryMinHeap
  attr_reader :store, :prc

  def initialize(&prc)
    @store = []
    @prc ||= Proc.new { |el1, el2| el1 <=> el2 }
  end

  def count
    @store.length
  end

  def extract(&prc)
    prc ||= Proc.new { |el1, el2| el1 <=> el2 }
    @store[0], @store[-1] = @store[-1], @store[0]
    el = @store.pop
    BinaryMinHeap.heapify_down(@store, 0, @store.length, &prc)
    el
  end

  def peek
    @store[0]
  end

  def push(val, &prc)
    prc ||= Proc.new { |el1, el2| el1 <=> el2 }
    length = @store.length
    @store.push(val)
    BinaryMinHeap.heapify_up(@store, length, &prc)
  end

  public
  def self.child_indices(len, parent_index)
    indices = []
    child1 = parent_index * 2 + 1
    child2 = parent_index * 2 + 2
    indices << child1 if child1 < len
    indices << child2 if child2 < len
    indices
  end

  def self.parent_index(child_index)
    raise Exception, 'root has no parent' if child_index == 0
    (child_index - 1) / 2
  end

  def self.heapify_down(array, parent_idx, len = array.length, &prc)
    prc ||= Proc.new { |el1, el2| el1 <=> el2 }
    parent = array[parent_idx]
    child_indices = self.child_indices(len, parent_idx)
    return if child_indices.length == 0
    if child_indices.length == 1
      child = array[child_indices[0]]
      child_idx = child_indices[0]
    else
      if prc.call(array[child_indices[0]], array[child_indices[1]]) <= 0
        child = array[child_indices[0]]
        child_idx = child_indices[0]
      else
        child = array[child_indices[1]]
        child_idx = child_indices[1]
      end
    end

    until prc.call(parent, child) <= 0
      array[parent_idx], array[child_idx] = array[child_idx], array[parent_idx]
      parent_idx = child_idx
      parent = array[parent_idx]

      child_indices = self.child_indices(len, parent_idx)
      break if child_indices.length == 0

      if child_indices.length == 1
        child = array[child_indices[0]]
        child_idx = child_indices[0]
      else
        if prc.call(array[child_indices[0]], array[child_indices[1]]) <= 0
          child = array[child_indices[0]]
          child_idx = child_indices[0]
        else
          child = array[child_indices[1]]
          child_idx = child_indices[1]
        end
      end
    end
    array
  end

  def self.heapify_up(array, child_idx, len = array.length, &prc)
    return if child_idx == 0
    prc ||= Proc.new { |el1, el2| el1 <=> el2 }
    child = array[child_idx]
    parent_idx = self.parent_index(child_idx)
    parent = array[parent_idx]

    until prc.call(child, parent) >= 0
      array[parent_idx], array[child_idx] = array[child_idx], array[parent_idx]
      child_idx = parent_idx
      break if child_idx == 0
      parent_idx = self.parent_index(child_idx)
      parent = array[parent_idx]
    end
    array
  end
end
