require_relative 'p05_hash_map'

def can_string_be_palindrome?(string)
  hsh_map = HashMap.new
  string.each_char do |char|
    if hsh_map.include?(char)
      count = hsh_map.get(char)
      hsh_map.set(char, count + 1)
    else
      hsh_map.set(char, 1)
    end
  end

  if string.length % 2 == 0
    counts = []
    hsh_map.each { |key_val| counts << key_val[1] }
    counts.uniq.all? { |el| el % 2 == 0 }
  else
    counts = []
    hsh_map.each { |key_val| counts << key_val[1] }
    odds = 0
    counts.each { |el| odds += 1 if (el % 2 !=0) }
    odds > 1 ? false : true
  end
end
