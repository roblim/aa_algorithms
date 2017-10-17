require_relative "static_array"

class RingBuffer
  attr_reader :length

  def initialize
    @store = StaticArray.new(8)
    @capacity = 8
    @length = 0
    @start_idx = 0
  end

  # O(1)
  def [](index)
    check_index(index)
    @store[index]
  end

  # O(1)
  def []=(index, val)
    check_index(index)
    @store[index] = val
  end

  # O(1)
  def pop
    el = @store[(@start_idx - 1) % @length]
    @length -= 1
    el
  end

  # O(1) ammortized
  def push(val)
    resize! if @length == @capacity
    if @length == 0
      @store[0] = val
      @length = 1
    else
      @store[(@start_idx + @length) % @length] = val
      @length += 1
    end
    @store
  end

  # O(1)
  def shift
  end

  # O(1) ammortized
  def unshift(val)
  end

  protected
  attr_accessor :capacity, :start_idx, :store
  attr_writer :length

  def check_index(index)
    raise Exception, 'index out of bounds' if (index + 1) > self.length
  end

  def resize!
    new_arr = StaticArray.new(@capacity * 2)
    @capacity = @capacity * 2
    idx = 0
    count = 0
    while count < @length
      new_arr[idx] = @store[idx]
      idx += 1
      count += 1
    end
    @store = new_arr
  end
end
