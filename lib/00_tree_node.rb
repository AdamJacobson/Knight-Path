class PolyTreeNode
  attr_reader :parent, :value
  attr_accessor :children
  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end

  def parent=(new_parent)
    @parent.children.delete(self) unless @parent.nil?
    @parent = new_parent
    @parent.children << self unless @parent.nil?
  end

  def add_child(child_node)
    child_node.parent = self
    # @children << child_node
  end

  def remove_child(child_node)
    child_node.parent = nil
    raise "Not a child." unless @children.include?(child_node)
    @children.delete(child_node)
  end

  def dfs(target_value)
    return self if @value == target_value
    @children.each do |child|
      result = child.dfs(target_value)
      return result if result
    end
    nil
  end

  def bfs(target_value)
    return self if @value == target_value
    queue = [self]
    until queue.empty?
      current_node = queue.shift
      return current_node if current_node.value == target_value
      queue.concat(current_node.children)
    end
    nil
  end

end
