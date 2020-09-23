#pattern = <<HERE
#0
#0
#1 2
#2 3
#1 2
#2 3
#HERE

file = ARGV[0]
title = file.split(".").first

pattern = IO.read(file)

nodes = {}
pattern.split("\n").each_with_index do |l,i|
    nodes[i] = l.split(" ").map(&:to_i)
end

nodes_mod = {}

nodes.each do |i, parents|
    nodes_mod[i] = parents.filter{|p| p != 0}.map{|p| i-p}.reverse
end

#pattern_mod = <<HERE
#
#
#0 1
#0 1
#2 3
#2 3
#HERE

#nodes = {}
#pattern_mod.split("\n").each_with_index do |l,i|
#    nodes[i] = l.split(" ").map(&:to_i)
#end

puts "mkdir -p branch-art-#{title}"
puts "cd branch-art-#{title}"
puts "rm -rf .git"
puts "git init"

puts "TREE=$(git write-tree)"
nodes_mod.each do |i, parents|
    parent_string = parents.map{|p| "-p $COMMIT#{p}"}.join(" ")
    puts "COMMIT#{i}=$(git commit-tree $TREE #{parent_string} -m '#{i}')"
end

reverse = {}
nodes_mod.each do |i, parents|
    parents.each do |p|
        if not reverse.include?(p)
            reverse[p] = []
        end
        reverse[p] << i
    end
end

unreferenced = nodes_mod.keys - reverse.keys

if unreferenced.size > 1
    parent_string = unreferenced.map{|p| "-p $COMMIT#{p}"}.join(" ")
    puts "FINAL=$(git commit-tree $TREE #{parent_string} -m '#{nodes_mod.size}')"
    puts "git update-ref refs/heads/main $FINAL"
else
    puts "git update-ref refs/heads/main $COMMIT#{nodes_mod.size-1}"
end
