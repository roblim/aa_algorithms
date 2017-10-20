require_relative 'heap'

def k_largest_elements(array, k)
  heap = BinaryMinHeap.new
  until array.empty?
    heap.push(array.pop) { |el1, el2| el2 <=> el1 }
  end
  result = []
  until result.length == k
    result << heap.extract() { |el1, el2| el2 <=> el1 }
  end
  result
end
