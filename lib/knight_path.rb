class KnightPathFinder
  DELTAS = [[-2, -1], [-1, -2], [-2, 1],
            [1, -2], [-1, 2], [2, -1], [2, 1], [1, 2]]

  def initialize(starting_pos)
    @starting_pos = starting_pos
    @visited = [starting_pos]
  end

  def build_move_tree
    @move_tree
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
  end

  def new_move_positions(pos)
    new_moves = self.class.valid_moves(pos).reject do |move|
      @visited.include(move)
    end
    @visited.concat(new_moves)
    new_moves
  end

end
