# zadanie 2

def sum(a)
    a.reduce(:+)
end

puts sum [1, 2, 3]


# zadanie 4

Words = %w{ zero jeden dwa trzy cztery piec szesc siedem osiem dziewiec }
    
def words(n)
	return Words[n] if n < 10
    q, r = n / 10, n % 10
    words(q) + " " + Words[r]
end

puts words 123


# zadanie 5

UnWords = {
    "zero" => 0,
    "jeden" => 1,
    "dwa" => 2,
    "trzy" => 3,
    "cztery" => 4,
    "piec" => 5,
    "szesc" => 6,
    "siedem" => 7,
    "osiem" => 8,
    "dziewiec" => 9
}

def unwords(a)
    a.inject(0) { |n, w| 10 * n + UnWords[w] }
end

puts unwords ["jeden", "dwa", "trzy"]


# zadanie 6

def pascal(n)
    line1 = [1]
    p line1
    
    (1...n).each do
        line2 = [1]
        for i in 0...(line1.length - 1)
            line2 << (line1[i] + line1[i + 1])
        end
        line2 << 1
        
        line1 = line2
        p line1
    end
end

pascal 3
