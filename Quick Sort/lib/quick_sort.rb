class QuickSort
  # Quick sort has average case time complexity O(nlogn), but worst
  # case O(n**2).

  # Not in-place. Uses O(n) memory.
  def self.sort1(array)
    pivot = array[0]
    return array if array.length <= 1
    left = array.drop(1).select { |n| n <= pivot}
    right = array.drop(1).select { |n| n > pivot}

    sortedLeft = QuickSort.sort1(left)
    sortedRight = QuickSort.sort1(right)

    sortedLeft + [pivot] + sortedRight
  end

  # In-place.
  def self.sort2!(array, start = 0, length = array.length, &prc)
    return array if length <= 1
    prc ||= Proc.new { |n1, n2| n1 <=> n2 }
    pivot_idx = QuickSort.partition(array, start, length, &prc)
    QuickSort.sort2!(array, start, pivot_idx - start, &prc)
    QuickSort.sort2!(array, pivot_idx + 1, length - pivot_idx - 1, &prc)
  end
  
  def self.partition(array, start, length, &prc)
    return start if length == 1
    prc ||= Proc.new { |n1, n2| n1 <=> n2 } 
    partition = start + 1
    pivot = array[start]
    (partition).upto(start + length - 1).each do |idx|
      if prc.call(array[idx], pivot) == -1
        array[partition], array[idx] = array[idx], array[partition]
        partition += 1
      end
    end

    array[partition - 1], array[start] = array[start], array[partition - 1]
    partition - 1
  end
end