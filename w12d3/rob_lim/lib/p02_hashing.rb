class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    self.each_with_index.reduce(0) { |accum, (el, idx)| accum + (el.hash + idx).hash }
  end
end

class String
  def hash
    self.chars.each_with_index.reduce(0) { |accum, (el, idx)| accum + (idx + el.ord).hash }
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    self.to_a.sort.hash
  end
end
