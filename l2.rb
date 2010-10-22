# zadanie 1

class Graph
    def initialize
        @g = {}
    end
    
    def add_edge(a, b)
        if not @g.has_key?(a)
            @g[a] = [b]       
        else
            @g[a] << b  
        end
        
        if not @g.has_key?(b)
            @g[b] = [a]       
        else
            @g[b] << a  
        end
    end
    
    def find_paths(a, b, path = [])   
        path += [a]
    
        if a == b
            return [path]
        end
    
        if not @g.has_key?(a)
            return []
        end
    
        paths = []
    
        @g[a].each do |n|
            if not path.include?(n)
                newpaths = find_paths(n, b, path)
                newpaths.each do |newpath|
                    paths << newpath
                end
            end
        end
    
        return paths
    end
end


map = Graph.new

map.add_edge("Polska", "Niemcy")
map.add_edge("Polska", "Czechy")
map.add_edge("Polska", "Slowacja")
map.add_edge("Niemcy", "Francja")
map.add_edge("Niemcy", "Szwajcaria")
map.add_edge("Niemcy", "Austria")
map.add_edge("Niemcy", "Czechy")
map.add_edge("Czechy", "Austria")
map.add_edge("Czechy", "Wegry")
map.add_edge("Czechy", "Slowacja")
map.add_edge("Slowacja", "Austria")
map.add_edge("Slowacja", "Wegry")
map.add_edge("Francja", "Szwajcaria")
map.add_edge("Francja", "Wlochy")
map.add_edge("Szwajcaria", "Wlochy")
map.add_edge("Szwajcaria", "Austria")


map.find_paths("Polska", "Wlochy").each do |path|
    p path
end

puts "Najkrotsza droga z Polski do Wloch: "
p map.find_paths("Polska", "Wlochy").sort_by { |path| path.length }.first
