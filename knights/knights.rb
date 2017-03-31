require_relative 'node'

class Knights
  attr_reader :start

  MOVES = [[2,1],[2,-1],[-2,1],[-2,-1],[1,2],[1,-2],[-1,2],[-1,-2]]

  def self.valid_moves(pos)
    possible_moves = []
    row, col = pos
    MOVES.each do |move|
      new_pos = [move[0] + row, move[1] + col]
      possible_moves << new_pos if Knights.valid?(new_pos)
    end
    possible_moves
  end

  def self.valid?(pos)
    pos.all? {|num| num.between?(0,7) }
  end

  def initialize(visited = [0,0])
    @visited = [visited]
    @start = Node.new(visited)
  end

  def new_positions(pos)
    Knights.valid_moves(pos).reject { |move| @visited.include?(move)}
  end

  def build_tree
    moves = [@start]
    until moves.empty?
      node = moves.shift
      new_moves = new_positions(node.value)

      new_moves.each do |pos|
        child = Node.new(pos)
        node.add_child(child)
        moves << child
        @visited << pos
      end
    end
  end

  def find_path(end_pos)
    build_tree
    @start.dfs(end_pos).trace_path
  end

end
