require 'pry'

INITIAL_MARKER = ' '
PLAYER_MARKER = 'X'
COMPUTER_MARKER = 'O'
WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                [[2, 5, 8], [1, 4, 7], [3, 6, 9]] + # columns
                [[1, 5, 9], [3, 5, 7]] # diagonals

def prompt(msg)
  puts "=> #{msg}"
end

# rubocop:disable Metrics/AbcSize
def display_board(brd)
  system 'clear'
  puts "Player: #{PLAYER_MARKER}. Computer: #{COMPUTER_MARKER}."
  puts ""
  puts "     |     |"
  puts "  #{brd[1]}  |  #{brd[2]}  |  #{brd[3]}"
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{brd[4]}  |  #{brd[5]}  |  #{brd[6]}"
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{brd[7]}  |  #{brd[8]}  |  #{brd[9]}"
  puts "     |     |"
  puts ""
end
# rubocop:enable Metrics/AbcSize

def display_score(score)
  prompt "============"
  puts "   SCORE"
  puts "   Player: #{score['Player']}"
  puts "   Computer: #{score['Computer']}"
  puts "   Ties: #{score['Tie']}"
  prompt "============"
end

def display_round_winner(brd, score)
  if someone_won?(brd)
    prompt "#{detect_winner(brd)} won!"
    score[detect_winner(brd)] += 1
  else
    prompt "It's a tie!"
    score['Tie'] += 1
  end
end

def initialize_board
  new_board = {}
  (1..9).each { |num| new_board[num] = INITIAL_MARKER }
  new_board
end

def empty_squares(brd)
  brd.keys.select { |num| brd[num] == INITIAL_MARKER }
end

def player_places_peice!(brd)
  square = ''
  loop do
    prompt "Choose a square: #{joinor(empty_squares(brd))}"
    square = gets.chomp.to_i
    break if empty_squares(brd).include?(square)
    puts "Invalid choice"
  end
  brd[square] = PLAYER_MARKER
end

def computer_offense(brd)
square = nil
  WINNING_LINES.each do |line|
    if brd.values_at(*line).count(COMPUTER_MARKER) == 2
      line.each do |sq|
        square = sq if brd[sq] == ' '
      end
      if square == nil
        next
      else
        break
      end
    end
  end
  square
end

def computer_defense(brd)
  square = nil
  WINNING_LINES.each do |line|
      if brd.values_at(*line).count(PLAYER_MARKER) == 2
        line.each do |sq|
          square = sq if brd[sq] == ' '
        end
        if square == nil
          next
        else
          break
        end
      else
        next
      end
    end
  square
end
def computer_places_piece!(brd)
  square = computer_offense(brd)
  if square
    return brd [square] = COMPUTER_MARKER
  else
    square = computer_defense(brd)
  end
  square = empty_squares(brd).sample if square == nil
  brd[square] = COMPUTER_MARKER
end

def board_full?(brd)
  empty_squares(brd).empty?
end

def someone_won?(brd)
  !!detect_winner(brd)
end

def detect_winner(brd)
  WINNING_LINES.each do |line|
    if brd.values_at(*line).all?(PLAYER_MARKER)
      return 'Player'
    elsif brd.values_at(*line).all?(COMPUTER_MARKER)
      return 'Computer'
    end
  end
  nil
end

def joinor(brd, symbol = ', ', joiner = 'or')
  case brd.size
  when 0 then ''
  when 1 then brd.first
  when 2 then brd.join(" #{joiner} ")
  else
    brd[-1] = "#{joiner} #{brd.last}"
    brd.join(symbol)
  end
end

def hit_enter(round)
  prompt "Hit enter for Round #{round} or type 'exit' to leave early"
  gets.chomp
end

# Tic Tac Toe Game Logic
prompt "Welcome to Tic Tac Toe!"
prompt "First to 5 wins, takes the lot!"
loop do
  score = {'Player' => 0, 'Computer' => 0, 'Tie' => 0}
  round = 1

  loop do
    board = initialize_board

    loop do
      display_board(board)

      player_places_peice!(board)
      break if someone_won?(board) || board_full?(board)

      computer_places_piece!(board)
      break if someone_won?(board) || board_full?(board)
    end

    display_board(board)
    display_round_winner(board, score)

    round += 1
    display_score(score)
    early_exit = hit_enter(round)

    break if score['Player'] == 5 ||
             score['Computer'] == 5 ||
             early_exit.downcase.start_with?('e')
  end
  prompt "Play Again? y/n"
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end

prompt "Thanks for playing Tic Tac Toe! Goodbye!"
