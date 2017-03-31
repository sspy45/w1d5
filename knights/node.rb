class Node
  attr_accessor :value, :parent, :children

  def initialize(value)
    @value, @parent, @children = value, nil, []
  end

  def parent
    @parent
  end

  def parent=(node)
    @parent.children.delete(self) unless @parent.nil?
    @parent = node
    return nil if node.nil?
    node.children << self unless node.children.include?(self)
  end

  def children
    @children
  end

  def add_child(child)
    @children << child unless @children.include?(child)
    child.parent = self
  end

  def remove_child(child)
    raise ArgumentError, 'No child found' unless @children.include?(child)
    @children.delete(child).parent = nil
  end

  def value
    @value
  end

  def dfs(target)
    return self if self.value == target
    return nil if @children.empty?

    @children.each do |child|
      target_node = child.dfs(target)
      return target_node unless target_node.nil?
    end
    nil
  end

  def bfs(target)
    nodes = [self]
    until nodes.empty?
      node = nodes.shift
      return node if node.value == target
      node.children.each do |child|
        nodes << child
      end
    end
    nil
  end

  def trace_path
    current_node = self
    path = []

    until current_node == nil
      path << current_node.value
      current_node = current_node.parent
    end

    path.reverse
  end
end
