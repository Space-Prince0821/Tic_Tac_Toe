class Player
    attr_reader :name, :symbol
  
    def initialize(name, symbol)
      @name = name
      @symbol = symbol
    end
  
    def make_move
      print "#{@name}, enter your move (1-9): "
      gets.chomp.to_i
    end
end

class Board
    def initialize
      @grid = (1..9).to_a.map(&:to_s)
    end
  
    def display_board
      puts " #{@grid[0]} | #{@grid[1]} | #{@grid[2]} "
      puts "---|---|---"
      puts " #{@grid[3]} | #{@grid[4]} | #{@grid[5]} "
      puts "---|---|---"
      puts " #{@grid[6]} | #{@grid[7]} | #{@grid[8]} "
    end
  
    def update_board(position, symbol)
      @grid[position - 1] = symbol
    end
  
    def win?
      winning_combinations = [
        [0, 1, 2], [3, 4, 5], [6, 7, 8],
        [0, 3, 6], [1, 4, 7], [2, 5, 8],
        [0, 4, 8], [2, 4, 6]
      ]
      winning_combinations.any? { |combo| combo.all? { |pos| @grid[pos] == 'X' } || combo.all? { |pos| @grid[pos] == 'O' } }
    end
  
    def tie?
      @grid.all? { |cell| cell == 'X' || cell == 'O' }
    end
end
  
class Game
    def initialize
      @board = Board.new
      @player1 = Player.new('Player 1', 'X')
      @player2 = Player.new('Player 2', 'O')
      @current_player = @player1
    end
  
    def start_game
      loop do
        @board.display_board
        position = @current_player.make_move
  
        until valid_move?(position)
          puts "Invalid move! Choose an empty position."
          position = @current_player.make_move
        end
  
        @board.update_board(position, @current_player.symbol)
  
        if @board.win?
          @board.display_board
          puts "#{@current_player.name} wins!"
          break
        elsif @board.tie?
          @board.display_board
          puts "It's a tie!"
          break
        end
  
        switch_players
      end
    end
  
    private
  
    def switch_players
      @current_player = (@current_player == @player1) ? @player2 : @player1
    end
  
    def valid_move?(position)
      position.between?(1, 9) && @board.instance_variable_get(:@grid)[position - 1] != 'X' && @board.instance_variable_get(:@grid)[position - 1] != 'O'
    end
end

game = Game.new
game.start_game