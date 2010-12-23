# zadanie 3

class Element
  include Comparable
  attr_reader :x, :y
  
  def initialize(x, y)
    @x, @y = x, y
  end
  
  def <=> (e)
    if @x < e.x || (@x == e.x && @y < e.y)
      -1
    elsif @x == e.x && @y == e.y
      0
    else
      1
    end
  end
  
  def to_s
    "(#{@x}, #{@y})"
  end
end

class Node
  attr_accessor :v, :l, :r
    
  def initialize(v)
    @v, @l, @r = v, nil, nil
  end
end

class BinaryTree
  def initialize
    @root = nil
  end
  
  def insert(v)
    @root = ins(v, @root)
  end
  
  def delete(v)
    @root = del(v, @root)
  end
  
  def find(v, node = @root)
    if node.nil? 
      return false
    elsif v < node.v 
      return find(v, node.l)
    elsif v > node.v 
      return find(v, node.r)
    else 
      return true
    end
  end
  
  def each(node = @root, &block)
    return false if node.nil?
    
    each(node.l, &block)
    yield node.v
    each(node.r, &block)
  end
  
  def empty?
    @root.nil?
  end
  
  private
    def ins(v, node)
      if node.nil? 
        node = Node.new(v)
      elsif v <= node.v
        node.l = ins(v, node.l)
      else
        node.r = ins(v, node.r)
      end
      
      return node
    end

    def del(v, node)
      if node.nil? 
        return nil
      elsif v < node.v
        node.l = del(v, node.l)
      elsif v > node.v
        node.r = del(v, node.r)
      elsif node.l && node.r
        node.v = delMin(node)
      else
        node = node.l ? node.l : node.r
      end
      
      return node
    end
    
    def delMin(tree)
      parent = tree.r
      minChild = parent.l
 
      if minChild.nil?
        tree.r = parent.r
        return parent.v
      end
 
      while minChild.l
        parent = minChild
        minChild = minChild.l
      end
 
      parent.l = minChild.r
      return minChild.v
    end
end

bt = BinaryTree.new
elems = []
10.times { elems << Element.new(rand(10), rand(10)) }

elems.each { |e| bt.insert(e) }
bt.each { |e| print e, " " }
print "\n"

print "Find #{elems.last}: "
puts bt.find(elems.last)

bt.delete(Element.new(-1, -1))
elems.each do |e| 
  puts "Del #{e}: "
  bt.delete(e) 
  bt.each { |e| print e, " " }
  print "\n"
end

puts "Tree empty?"
puts bt.empty?

tree = BinaryTree.new
[5, 3, 7, 1, 2, 6].each { |e| tree.insert(e) }
tree.each { |e| print e, " " }
print "\n"
puts tree.find(3)
tree.delete(3)
tree.each { |e| print e, " " }
puts tree.find(3)
