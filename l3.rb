# zadanie 2

def primes(n)
    sieve = [nil, nil] + (2..n).to_a
    
    (2..Math.sqrt(n)).each do |i|
        next unless sieve[i]
        (i*i).step(n, i) do |j|
            sieve[j] = nil
        end
    end
    
    sieve.compact
end

p primes(18)


# zadanie 4

def factors(n)
  return [] if n == 0 or n == 1
  factors = []
  primes(Math.sqrt(n)).each do |p|
      i = 0
      while n % p == 0
          i += 1
          n /= p
      end
      factors << [p, i] if i != 0
  end
  factors
end

p factors(756)
