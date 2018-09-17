class Game
	attr_accessor :board
	def initialize
		@board = Array.new(3) { [:" "] * 3 }
		@winner = nil
		play
	end


	def play
		puts "Welcome to Tic Tac Toe"
		puts "Player 1, please choose 'x' or 'o'."
		letter = gets.chomp.downcase
		p letter
		until letter == "x" || letter == "o"
			puts "Please enter x or o!"
			letter = gets.chomp.downcase
		end
		@player1 = Player.new(letter.to_sym)
		@current_player = @player1
		if letter == "o"
			puts "Player 2, you will then be x."
			@player2 = Player.new("x".to_sym)
		else
			puts "Player 2, you will then be o."
			@player2 = Player.new("o".to_sym)
		end
		until game_ended?
			display_board
			puts "#{@current_player.letter}, please enter the row (from 1-3) you want to place your letter on."
			row = gets.chomp.to_i
			until row <= 3 and row >= 1
				puts "Please enter a number between 1 and 3!"
				row = gets.chomp.to_i
			end

			puts "#{@current_player.letter}, please enter the column (from 1-3) you want to place your letter on."
			column = gets.chomp.to_i
			until column <= 3 and column >= 1
				puts "Please enter a number between 1 and 3!"
				column = gets.chomp.to_i
			end

			begin
				@board = @current_player.place_letter(row, column, board)
				@current_player = switch_player
			rescue
				puts "That spot is taken! Please choose an empty spot."
			end
		end


		if @winner.nil?
			puts "Tie game!"
		else 
			puts "#{@winner.letter} wins!"
			display_board
		end
	end

	def display_board
		puts "
		_#{@board[0][0].to_s}_|_#{@board[1][0].to_s}_|_#{@board[2][0].to_s}_
		_#{@board[0][1].to_s}_|_#{@board[1][1].to_s}_|_#{@board[2][1].to_s}_
		 #{@board[0][2].to_s} | #{@board[1][2].to_s} | #{@board[2][2].to_s}
		"
	end

	def switch_player
		if @current_player == @player1
			@current_player = @player2
		else
			@current_player = @player1
		end
	end



	def game_ended?
		columns = @board
		rows = @board.transpose
		diagonals  = [[@board[0][0], @board[1][1], @board[2][2]], [@board[0][2], @board[1][1], @board[2][0]]]
		
		winning_combos = columns + rows + diagonals

		winning_combos.each do |combo|
			if combo == [@player1.letter]*3
				@winner = @player1
				return true
			elsif combo == [@player2.letter]*3
				@winner = @player2
				return true
			end
		end

		columns.each do |column|
			return false if column.include?(:" ")
		end
		return true
	end



	def force_winner
		@board[0][0] = :x
		@board[1][1] = :x
		@board[2][2] = :x
		p @board
	end





	class Player
		attr_reader :letter
		def initialize(letter)
			@letter = letter
		end

		def place_letter(row, col, board)
			row = row -1
			col = col -1
			if board[row][col] == :" "
				board[row][col] = @letter
			else
				raise ArgumentError
			end
			board
		end

	end
end

Game.new()
