class Game
  attr_accessor :board, :active_player, :inactive_player, :selection, :player_input
  attr_reader :win_matches, :coordinates

  def initialize
    @board = [[1, 2, 3],
              [4, 5, 6],
              [7, 8, 9]]
    @active_player = "X"
    @inactive_player = "O"
    @player_input = String.new
    @selection = []
    @coordinates = [[0,0],[0,1],[0,2],
                    [1,0],[1,1],[1,2],
                    [2,0],[2,1],[2,2]]
    @win_matches = [[0,3,6],[1,4,7],[2,5,8], # Vertical Matches
                    [0,1,2],[3,4,5],[6,7,8], # Horizontal Matches
                    [0,4,8],[6,4,2]] # Diagonal Matches
  end

  def display
    board.map do |row|
      puts row.join(" | ").center(20)
    end
  end

  def valid_input?
    player_input.to_i.between?(1,9)
  end

  def translate_input
    coordinates[player_input.to_i - 1].each do |num|
      selection << num
    end
  end

  def valid_move?
    board[selection.first][selection.last].ord <= 9
  end

  def put_to_board
    board[selection.first][selection.last] = active_player
  end

  def win?
    win_matches.any? do |match|
      match.all? { |cell| flat_board[cell] == active_player }
    end
  end

  def draw?
    flat_board.all? do |element| 
      element.class == String
    end
  end

  # This method switches the symbols X and O 
  # between active_player and inactive_player
  def switch_players 
    @active_player, @inactive_player = @inactive_player, @active_player
  end

  private

  def flat_board
    board.flatten
  end
end

p = Game.new
p.display
puts "\nWelcome to Tic-Tac-Toe! Simply type in the number of the square\n
    you wish to place your character in."

loop do
  puts "#{p.active_player}'s turn:"
  p.player_input = gets.chomp
  if p.valid_input?
    p.translate_input
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
      p.switch_players    
    else
      puts "Not a valid move! That space is taken"
    end
  else
    puts "Not a valid input! Input must be 1 - 9."
  end
  p.selection = []  
end
