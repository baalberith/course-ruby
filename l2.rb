# zadanie 1

map = { 
    "Polska" => ["Niemcy", "Czechy", "Slowacja"],
    "Niemcy" => ["Francja", "Szwajcaria", "Austria", "Czechy", "Polska"],
    "Czechy" => ["Niemcy", "Austria", "Wegry", "Slowacja"],
    "Slowacja" => ["Czechy", "Austria", "Wegry"],
    "Francja" => ["Niemcy", "Szwajcaria", "Wlochy"],
    "Szwajcaria" => ["Niemcy", "Wlochy", "Austria"]
}

def all_paths(graph, a, b, path = [])   
    path += [a]
    
    if a == b
        return [path]
    end
    
    if not graph.has_key?(a)
        return []
    end
    
    paths = []
    
    graph[a].each do |n|
        if not path.include?(n)
            newpaths = all_paths(graph, n, b, path)
            newpaths.each do |newpath|
                paths << newpath
            end
        end
    end
    
    return paths
end

all_paths(map, "Polska", "Wlochy").each do |path|
    p path
end
