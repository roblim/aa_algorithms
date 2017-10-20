require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  attr_reader :count
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    if @map.include?(key)
      node = @map.get(key)
      node.remove
      update_node!(node)
      node.val
    else
      node = @store.append(key, calc!(key))
      @map.set(key, node)
      eject! if @map.count > @max
      node.val
    end
  end

  def to_s
    "Map: " + @map.to_s + "\n" + "Store: " + @store.to_s
  end

  private

  def calc!(key)
    # suggested helper method; insert an (un-cached) key
    @prc.call(key)
  end

  def update_node!(node)
    # suggested helper method; move a node to the end of the list
    @store.append(node.key, node.val)
    node.remove
  end

  def eject!
    node = @store.first
    node.remove
    @map.delete(node.key)
  end
end
