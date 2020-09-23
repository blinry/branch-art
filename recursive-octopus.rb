n = 4

n.times do
    n.times do
        puts "0"
    end
    puts (0..n).to_a.join(" ")
end

puts (0..(n-1)).map { |i|
    i*(n+1)+1
}.join(" ")
