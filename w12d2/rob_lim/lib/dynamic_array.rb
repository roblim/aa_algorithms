require_relative "static_array"

class DynamicArray
  attr_reader :length

  def initialize
    @store = StaticArray.new(8)
    @capacity = 8
    @length = 0
  end

  # O(1)
  def [](index)
    check_index(index)
    @store[index]
  end

  # O(1)
  def []=(index, value)
    check_index(index)
    @store[index] = value
  end

  # O(1)
  def pop
    raise Exception, 'index out of bounds' if @length == 0
    el = @store[@length - 1]
    @length -= 1
    el
  end

  # O(1) ammortized; O(n) worst case. Variable because of the possible
  # resize.
  def push(val)
    if @capacity == 0
      @store[0] = val
      @capacity = 1
      @length = 1
    elsif @length < @capacity
      @store[@length] = val
      @length += 1
    else
      resize!
      @store[@length] = val
      @length += 1
    end
    @store
  end

  # O(n): has to shift over all the elements.
  def shift
    raise Exception, 'index out of bounds' if @length == 0
    el = @store[0]
    idx = 1
    while idx < @length
      @store[idx - 1] = @store[idx]
      idx += 1
    end
    @length -= 1
    el
  end

  # O(n): has to shift over all the elements.
  def unshift(val)
    resize! if @capacity == @length
    idx = @length - 1
    while idx >= 0
      @store[idx + 1] = @store[idx]
      idx -= 1
    end
    @store[0] = val
    @length += 1
    @store
  end

  protected
  attr_accessor :capacity, :store
  attr_writer :length

  def check_index(index)
    raise Exception, 'index out of bounds' if (index + 1) > self.length
  end

  # O(n): has to copy over all the elements to the new store.
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
