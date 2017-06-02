require_relative '00_tree_node'
require 'byebug'

class KnightPathFinder
  DELTAS = [[-2, -1], [-1, -2], [-2, 1],
            [1, -2], [-1, 2], [2, -1], [2, 1], [1, 2]]

  def initialize(starting_pos)
    @starting_pos = starting_pos
    @visited = [starting_pos]
    build_move_tree
  end

  def move_tree
    @move_tree
  end

  def build_move_tree
    @move_tree = nil
    queue = [PolyTreeNode.new(@starting_pos)]

    until queue.empty?
      current_node = queue.shift

      @move_tree = current_node if @move_tree.nil?
      possible_moves = new_move_positions(current_node.value)
      possible_moves.each do |move|
        current_node.add_child(PolyTreeNode.new(move))
      end

      queue.concat(current_node.children)
    end
  end

  def self.valid_moves(pos)
    x, y = pos
    valid_moves = []

    DELTAS.each do |delta|
      new_x = x + delta.first
      new_y = y + delta.last

      if (0..7).include?(new_x) && (0..7).include?(new_y)
        valid_moves << [new_x, new_y]
      end
    end
    valid_moves
  end

  def new_move_positions(pos)
    valid_moves = self.class.valid_moves(pos)
    new_moves = valid_moves.reject do |move|
      @visited.include?(move)
    end
    @visited.concat(new_moves)
    new_moves
  end

  def find_path(end_pos)
    end_node = @move_tree.dfs(end_pos)
    trace_path_back(end_node)
  end

  def trace_path_back(end_node)
    path = []
    current_node = end_node
    until current_node.parent.nil?
      path.unshift(current_node.value)
      current_node = current_node.parent
    end
    path.unshift(current_node.value)
    path
  end

end
if __FILE__ == $PROGRAM_NAME
  kpf = KnightPathFinder.new([0,0])
  p kpf.find_path([7,7])
end
