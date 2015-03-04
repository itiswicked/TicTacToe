class Game
	attr_accessor :board, :active_symbol, :inactive_symbol
  attr_reader 	:player_input

	def initialize
    @board = [["-", "-", "-"],
              ["-", "-", "-"],
              ["-", "-", "-"]]
    @player_input = []
    @active_symbol = "X"
    @inactive_symbol = "O"
  end

  def display_rules
    puts "\nWelcome to Tic-Tac-Toe! 2 Players will take turns alternatively placing\n
    X's or O's on the board. When a player gets three in a row, they win!\n
    The board has a coordinate system, starting with 0,0 as the upper left\n
    cell and increasing in number as you go down and right. To select a cell\n
    to place your character in, simply type the coordinate numbers with a\n
    space in between: 1 1. 1 1 would refer to the center cell. Happy winning!"
  end

  def display_board
    board.map do |row|
      puts row.join(" | ").center(20)
    end
  end

   def user_prompt
    puts "#{active_symbol}'s turn:"
    player_input = gets.chomp
    player_input
  end

  def player_input=(input)
  	input.split(/,\s*/).each do |num|
  		@player_input << num.to_i
  	end
    put_to_board
  end

  def put_to_board
  	if check_board
    	board[player_input[0]][player_input[1]] = active_symbol
    	display_board
    	unless check_for_win
    		symbol_switch
        user_prompt
    	end
    else
      "That space is taken!"
      user_prompt
    end
  end

  private

  def symbol_switch
    active_symbol, inactive_symbol = inactive_symbol, active_symbol
  end

  def check_board
  	board[player_input[0]][player_input[1]] == "-"
  end

  def check_for_win; 
  	false
  end

end

a = Game.new
a.display_board
a.display_rules
a.user_prompt
