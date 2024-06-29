class TicTacToe
  @@player = "X"
  @@winner = ""

  def initialize
    puts "Name of the 1st player"
    @player_one = gets.chomp
    puts "Name of the 2nd player"
    @player_two = gets.chomp
    puts "Hi #{@player_one} and #{@player_two}!"
    @board = Array.new(3) { Array.new(3, "_") }
  end

  def display_board # Shows a board
    puts "\n" # Extra space
    puts "#{@board[0][0]} | #{@board[0][1]} | #{@board[0][2]}"
    puts "#{@board[1][0]} | #{@board[1][1]} | #{@board[1][2]}"
    puts "#{@board[2][0]} | #{@board[2][1]} | #{@board[2][2]}"
    puts "\n"
  end

  def moves # Gives an option of choosing a placement for every user
    while @@winner.empty?
      puts "#{current_player}'s turn:"
      choose_position
      if check_winner
        display_board
        puts "Congratulations, #{current_player}! You win!"
        return
      end
      switch_player
    end
  end

  def choose_position # Choosing a placement 
    puts "Choose row (0-2)" 
    row = gets.chomp.to_i
    if row > 2 || row < 0 # Checks if the row entered by the user is greater than 2 or less than 0
      puts "Invalid row number. Choose a number between 0 and 2." 
      choose_position # Make player to choose another placement
      return
    end

    puts "Choose column (0-2)"
    col = gets.chomp.to_i
    if col > 2 || col < 0
      puts "Invalid column number. Choose a number between 0 and 2."
      choose_position
      return
    end

    if @board[row][col] != "_" # Check if this position isn't taken
      puts "Position already taken. Choose another one." # If it already taken give this error
      choose_position 
      return
    end

    @board[row][col] = @@player
    display_board
  end

  def play_game
    move_count = 0
    while move_count < 9
      moves
      move_count += 1
    end
    puts "It's a draw!" if @@winner.empty?
  end

  def check_winner
    winning_combinations = [
      [[0, 0], [0, 1], [0, 2]], # Top row
      [[1, 0], [1, 1], [1, 2]], # Middle row
      [[2, 0], [2, 1], [2, 2]], # Bottom row
      [[0, 0], [1, 0], [2, 0]], # Left column
      [[0, 1], [1, 1], [2, 1]], # Middle column
      [[0, 2], [1, 2], [2, 2]], # Right column
      [[0, 0], [1, 1], [2, 2]], # Diagonal from top-left to bottom-right
      [[0, 2], [1, 1], [2, 0]]  # Diagonal from top-right to bottom-left
    ]

    winning_combinations.any? do |combination|
      if combination.all? { |position| @board[position[0]][position[1]] == @@player }
        @@winner = current_player
        true
      else
        false
      end
    end
  end

  private

  def current_player
    @@player == "X" ? @player_one : @player_two
  end

  def switch_player
    @@player = @@player == "X" ? "O" : "X"
  end
end

game = TicTacToe.new
game.display_board
game.play_game
