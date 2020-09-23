def triangle(n)
    n.times do
        puts "1"
    end
    n.times do |i|
        puts "1 #{2+i*2}"
    end
end

puts "0"
10.times do |i|
    triangle(i)
end
