class DynamicProgramming

  def initialize
    @blair_cache = { 1 => 1, 2 => 2 }
    @frog_cache = { 1 => [ [1] ], 2 => [ [1,1], [2] ], 3 => [ [1,1,1], [1,2], [2,1], [3] ] }
    @super_frog_cache = { 1 =>[[1]] }
  end

  def blair_nums(n)
    return @blair_cache[n] if @blair_cache[n]
    @blair_cache[n] = blair_nums(n - 1) + blair_nums(n - 2) + (2 * n - 3)
  end

  def frog_hops_bottom_up(n)
    cache = frog_cache_builder(n)
    cache[n]
  end

  def frog_cache_builder(n)
    cache = { 1 => [ [1] ], 2 => [ [1,1], [2] ], 3 => [ [1,1,1], [1,2], [2,1], [3] ] }
    return cache if cache.keys.include?(n)
    4.upto(n) do |step|
      result = []
      cache[step - 1].each { |el| result << (el.clone << 1) }
      cache[step - 2].each { |el| result << (el.clone << 2) }
      cache[step - 3].each { |el| result << (el.clone << 3) }
      cache[step] = result
    end
    cache
  end

  def frog_hops_top_down(n)
    # return @frog_cache[n] if @frog_cache[n]
    # result = []
    # frog_hops_top_down(n - 1).each { |el| result << (el.clone << 1) }
    # frog_hops_top_down(n - 2).each { |el| result << (el.clone << 2) }
    # frog_hops_top_down(n - 3).each { |el| result << (el.clone << 3) }
    # @frog_cache[n] = result
    frog_hops_top_down_helper(n)
  end

  def frog_hops_top_down_helper(n)
    return @frog_cache[n] if @frog_cache[n]
    result = []
    frog_hops_top_down(n - 1).each { |el| result << (el.clone << 1) }
    frog_hops_top_down(n - 2).each { |el| result << (el.clone << 2) }
    frog_hops_top_down(n - 3).each { |el| result << (el.clone << 3) }
    @frog_cache[n] = result
  end

  def super_frog_hops(n, k)
    return [[1, 1], [2]] if n == 2 && k == 2
    return @super_frog_cache[n] if @super_frog_cache[n]
    result = []
    1.upto(k) do |idx|
      if n - idx > 0
        result.concat(super_frog_hops(n - idx, k).map {|steps| steps + [idx]})
      end
    end
    if n <= k
      result << [n]
    end
    @super_frog_cache[n] = result
  end

  def knapsack(weights, values, capacity)
    return 0 if capacity == 0 || weights.length == 0
    result_table = knapsack_table(weights, values, capacity)
    result_table[capacity][weights.length - 1]
  end

  # Helper method for bottom-up implementation
  def knapsack_table(weights, values, capacity)
    result_table = []
    (0..capacity).each do |idx1|
      result_table[idx1] = []
      (0..weights.length - 1).each do |idx2|
        if idx1 == 0
          result_table[idx1][idx2] = 0
        elsif idx2 == 0
          result_table[idx1][idx2] = weights[0] > idx1 ? 0 : values[0]
        else
          opt1 = result_table[idx1][idx2 - 1]
          opt2 = idx1 < weights[idx2] ? 0 : result_table[idx1 - weights[idx2]][idx2 - 1] + values[idx2]
          optimum = [opt1, opt2].max
          result_table[idx1][idx2] = optimum
        end
      end
    end
    result_table
  end

  def maze_solver(maze, start_pos, end_pos)
  end
end
