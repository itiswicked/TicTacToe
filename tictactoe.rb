class Game
	attr_accessor :board, :active_symbol, :inactive_symbol, :selection
  attr_reader :win_matches, :coordinates

	def initialize
    @board = [[1, 2, 3],
              [4, 5, 6],
              [7, 8, 9]]
    @active_symbol = "X"
    @inactive_symbol = "O"
    @selection = []
    @coordinates = [[0,0],[0,1],[0,2],
                    [1,0],[1,1],[1,2],
                    [2,0],[2,1],[2,2]]
    @win_matches = [[0,3,6],[1,4,7],[2,5,8], # Vertical Matches
                    [0,1,2],[3,4,5],[6,7,8], # Horizontal Matches
                    [0,4,8],[6,4,2]] # Diagonal Matches
  end

  def show_rules
    puts "\nWelcome to Tic-Tac-Toe! Simply type in the number of the square you\n
    wish to place your character in."
  end

  def display
    board.map do |row|
      puts row.join(" | ").center(20)
    end
  end

   def prompt
    puts "#{active_symbol}'s turn:"
  end

  def translate_input=(player_input)
    coordinates[player_input.to_i - 1].each do |num|
      selection << num
    end
  end

  def put_to_board
    board[selection.first][selection.last] = active_symbol
  end

  def valid_move?
    board[selection.first][selection.last].ord <= 9
  end



  def win?
    win_matches.any? do |match|
      match.all? { |cell| flat_board[cell] == active_symbol }
    end
  end

  def draw?
    flat_board.all? do |element| 
      element.class == "String".class
    end
  end

  def switch_symbols
    @active_symbol, @inactive_symbol = @inactive_symbol, @active_symbol
  end

  private

  def flat_board
    board.flatten
  end
end

p = Game.new
p.display

loop do
  p.prompt
  p.translate_input = gets.chomp
  if p.valid_move?
    p.put_to_board
    p.display
    if p.win?
      puts "Winner!"
      break
    elsif p.draw?
      puts "Draw"
      break
    end
    p.switch_symbols    
  else
    puts "Not a valid move!"
  end
  p.selection = []  
end

