# Write a program that will output 
# the length of the Collatz Conjecture 
# for any given n.

def collatz(n, arr = [])
  while n != 1
    arr << n
    n = n.even? ? n/2 : n*3+1
  end
  arr.push(1)
end
puts collatz(3)
puts collatz(3).length

# Find the number (1 to 1,000,000) with
# the longest Collatz sequence.

class Collatz
  def initialize(min, max)
    @min = min
    @max = max 
    @cache = Array.new(max, 0)
  end

  def longest_length
    max_n, max_length = 0, 0
    (@min..@max).each do |n|
      length = length_for(n)
      if length > max_length
        max_n, max_length = n, length
      end
    end
    [max_n, max_length]
  end

  private def length_for(n)
    @cache[n -1] = next_for(n)
  end

  private def next_for(n)
    return 1 if n == 1
    return @cache[n - 1] if n <= @max && @cache[n - 1] != 0

    if n.even?
      1 + next_for(n/2)
    else
      1 + next_for(n*3+1)
    end
  end
end

collatz = Collatz.new(1, 1_000_000)
max_n, max_length = collatz.longest_length
puts "Number with longest Collatz sequence is #{max_n}"
puts "Longest sequence length is #{max_length}"
