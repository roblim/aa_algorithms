require_relative "static_array"
require 'byebug'

class RingBuffer
  attr_reader :length

  def initialize
    @store = StaticArray.new(8)
    @length = 0
    @capacity = 8
    @start_idx = 0
  end

  # O(1)
  def [](idx)
    # check_idx(idx)
    @store[(@start_idx + idx) % @capacity]
  end

  # O(1)
  def []=(idx, val)
    check_idx(idx)
    @store[(@start_idx + idx) % @capacity] = val
  end

  # O(1)
  def pop
    raise Exception, "index out of bounds" if (@length == 0)
    value = self[@length - 1]
    self[@length - 1] = nil
    @length -= 1
    value
  end

  # O(1) ammortized
  def push(val)
    resize! if (@length == @capacity)
    @length += 1
    self[@length - 1] = val
    val
  end

  # O(1)
  def shift
    raise Exception, "index out of bounds" if (@length == 0)
    value, self[0] = self[0], nil
    @start_idx = ((@start_idx + 1) % @capacity)
    @length -= 1
    value
  end

  # O(1) ammortized
  def unshift(val)
    resize! if (@length == @capacity)
    @start_idx = ((@start_idx - 1) % @capacity)
    @length += 1
    self[0] = val
  end

  protected
  attr_accessor :capacity, :start_idx, :store
  attr_writer :length

  def check_idx(idx)
    raise Exception, "index out of bounds" unless ((idx >= 0) && (idx < length))
  end

  def resize!
    if @length == @capacity
      new_buffer = StaticArray.new(@capacity * 2)
      idx = 0
      until idx == @length
        new_buffer[idx] = self[idx]
        idx += 1
      end
      @store = new_buffer
      @start_idx = 0
      @capacity *= 2
    end
  end
end
