require_relative 'tic_tac_toe'
require 'byebug'

class TicTacToeNode
  attr_accessor :board, :next_mover_mark, :prev_move_pos

  def initialize(board = Board.new, next_mover_mark = :x, prev_move_pos = nil)
    @board, @next_mover_mark, @prev_move_pos = board, next_mover_mark, prev_move_pos
  end

  def losing_node?(evaluator)
    return true if @board.winner == evaluator
    return false if @board.winner == nil 


    false
  end

  def winning_node?(evaluator)
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    pos_positions = all_positions.select { |pos| @board[pos].nil? }
    mark = switch_mark
    moves = []

    pos_positions.each do |pos|
      new_board = @board.dup
      new_board[pos] = @next_mover_mark
      moves << TicTacToeNode.new(new_board, mark, pos)
    end

    moves
  end

  def switch_mark
    @next_mover_mark == :x ? :o : :x
  end

  def all_positions
    all = []
    (0..2).each do |row|
      (0..2).each do |col|
        all << [row, col]
      end
    end

    all
  end
end
