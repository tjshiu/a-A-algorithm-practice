class DynamicProgramming

  def initialize
    @blair_cache = { 1 => 1, 2 => 2}
    @frog_cache =  {1 => [[1]], 
      2 => [[1,1], [2]], 
      3 => [[1, 1, 1], [1, 2], [2, 1], [3]], 
    }
    @super_frog_cache = {1 => [[1]]}
  end

  def blair_nums(n)
    # return 1 if n == 1
    # return 2 if n == 2

    return @blair_cache[n] if @blair_cache[n]

    ans = blair_nums(n - 1) + blair_nums(n - 2) + ((n-1) * 2 - 1)
    @blair_cache[n] = ans
    ans
  end

  
  def frog_hops_bottom_up(n)
    cache = frog_cache_builder(n)
    cache[n]
  end
  
  def frog_cache_builder(n)
    cache = {1 => [[1]], #add 3 [1, 3]
            2 => [[1,1], [2]], #add 2 [1, 1, 2], [2, 2]
            3 => [[1, 1, 1], [1, 2], [2, 1], [3]], #add 1 [1, 1, 1, 1], [1, 2, 1], [2, 1, 1], [3, 1]
    }
    return cache if n <= 3
    (4..n).each do |i|
      add_one = cache[i - 1].map { |arr| arr + [1] }
      add_two = cache[i - 2].map { |arr| arr + [2] } 
      add_three = cache[i - 3].map { |arr| arr + [3] } 
      cache[i] = add_one + add_two + add_three
    end
    cache
  end
  
  def frog_hops_top_down(n)
    frog_hops_top_down_helper(n)
  end
  
  def frog_hops_top_down_helper(n)
    return @frog_cache[n] if @frog_cache[n]

    ans = frog_hops_top_down_helper(n - 1).map { |arr| arr + [1] } + 
    frog_hops_top_down_helper(n - 2).map { |arr| arr + [2] } + 
    frog_hops_top_down_helper(n - 3).map { |arr| arr + [3] }

    @frog_cache[n] = ans
    ans
  end
  
  def super_frog_hops(n, k)
    cache =  {1 => [[1]] }
    k = n if n < k

    return cache[n] if cache[n]
    (2..n).each do |stairs|
      sum = []
      (1..k).each do |max_hops|
        add = cache[stairs - max_hops].map { |arr| arr + [max_hops] } if cache[stairs - max_hops]
        sum += add if cache[stairs - max_hops]
        sum += [[max_hops]] if max_hops == stairs
      end
      cache[stairs] = sum
    end

    cache[n]
  end
  
  def knapsack(weights, values, capacity)
    table = knapsack_table(weights, values, capacity)
    table[table.length - 1][weights.length - 1]
  end
  
  # Helper method for bottom-up implementation
  def knapsack_table(weights, values, capacity)
    table = Array.new(capacity + 1) { Array.new(weights.length) }
    
    weights.each_with_index do |weight, item_idx|
      (0..capacity).each do |curr_capacity|
        above = item_idx > 0 ? table[curr_capacity][item_idx - 1] : 0
        if curr_capacity < weight
          table[curr_capacity][item_idx] = above
        else
          if item_idx > 0
            with_item = values[item_idx] + table[curr_capacity - weight][item_idx - 1]
          else
            with_item = values[item_idx]
          end
          table[curr_capacity][item_idx] = [with_item, above].max
        end
      end
    end

    table
  end
  
  def maze_solver(maze, start_pos, end_pos)
  end
end

