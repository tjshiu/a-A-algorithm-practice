require_relative 'p05_hash_map'

def can_string_be_palindrome?(string) 
    hash = HashMap.new
  string.chars.each do |ch|
    if hash.include?(ch) 
        count = hash.get(ch)
        hash.set(ch, count + 1)
    else
        hash.set(ch, 1)
    end
  end
  odd_count = 0
  string.chars.uniq.each do |ch|
    if (hash.get(ch) % 2 != 0)
        odd_count += 1
        return false if odd_count > 1
    end
  end

  true
end
