require_relative "heap"

class Array
  def heap_sort!
    (1..length-1).each do |i|
      BinaryMinHeap.heapify_up(self, i) { |el1, el2| el2 <=> el1 }
    end

    heap_size = self.length
    until heap_size == 1
      self[0], self[heap_size-1] = self[heap_size-1], self[0]
      heap_size -= 1
      BinaryMinHeap.heapify_down(self, 0, heap_size) { |el1, el2| el2 <=> el1 }
    end
  end
end
