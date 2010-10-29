# zadanie 2

def primes(n)
  (2..n).select do |i|
    (2..Math.sqrt(i)).all? { |j| i % j != 0 }
  end
end

puts "liczby pierwsze <= 20: "
p primes(20)


# zadanie 4

def factors(n)
  primes(Math.sqrt(n)).select { |p| n % p == 0 }.map do |p|
    [p, (1..n).find { |i| n % (p**i) == 0 and n % (p**(i+1)) != 0 } ]
  end 
end

puts "dzielniki pierwsze 756: "
p factors(756)
