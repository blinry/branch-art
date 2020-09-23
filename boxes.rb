def box(n)
    n.times do |i|
        puts i
    end
    puts (1..n).to_a.join(" ")
end

puts "0"
10.times do |i|
    box(i)
end
