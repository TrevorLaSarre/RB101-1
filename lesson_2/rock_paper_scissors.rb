require 'yaml'

MESSAGES = YAML.load_file('rps_message.yml')

VALID_CHOICES = %w(rock paper scissors lizard spock)

## Prompt output Methods
def prompt(message)
  puts "=> #{MESSAGES[message]}"
end

# playing around with a prompt that allows interpolation from yaml file
# this raises an error in rubocop but I've already let them know about the bug
def var_prompt(message, variable)
  puts "=> #{format(MESSAGES[message], choice: variable)}"
end

## Player/Computer choice setting
# get user choice
def get_user_choice
  user_choice = ''
  loop do
    prompt('enter_choice')
    user_choice = convert_user_choice(gets.chomp)
    break if VALID_CHOICES.include?(user_choice)
    prompt('invalid')
  end
  user_choice
end

# computer choice
def computer_choice_generator
  VALID_CHOICES.sample
end

# allows user to type minimal letters for choice
def convert_user_choice(user_choice)
  user_choice = user_choice.downcase
  if user_choice.start_with?('r') then 'rock'
  elsif user_choice.start_with?('sc') then 'scissors'
  elsif user_choice.start_with?('p') then 'paper'
  elsif user_choice.start_with?('sp') then 'spock'
  elsif user_choice.start_with?('l') then 'lizard'
  end
end

## Display Methods
# display action of choices
def display_action(user_choice, computer_choice)
  win_actions = { 'rock' => { 'scissors' => 'ROCK SMASHES SCISSORS!',
                              'lizard' => 'ROCK SMASHES LIZARD!' },
                  'paper' => { 'rock' => 'PAPER COVERS ROCK!',
                               'spock' => 'PAPER DISPROVES SPOCK!' },
                  'scissors' => { 'paper' => 'SCISSORS CUTS PAPER!',
                                  'lizard' => 'SCISSORS DECAPITATE LIZARD!' },
                  'lizard' => { 'spock' => 'LIZARD POISONS SPOCK!',
                                'paper' => 'LIZARD EATS PAPER!' },
                  'spock' => { 'rock' => 'SPOCK VAPORIZES ROCK!',
                               'scissors' => 'SPOCK SMASHES SCISSORS!' } }

  if determine_victor(user_choice, computer_choice) == 'player'
    puts "=> #{win_actions[user_choice][computer_choice]}"
  elsif determine_victor(user_choice, computer_choice) == 'computer'
    puts "=> #{win_actions[computer_choice][user_choice]}"
  end
end

# displays winner of round
def display_victor(victor)
  if victor == 'player' || victor == 'computer'
    puts "=> #{victor.upcase} WINS!"
  else
    puts "=> It's a #{victor}!"
  end

  sleep(0.5)
end

# displays what each player (user and computer) chooses
def display_choices(user_choice, computer_choice)
  var_prompt('player_choice', user_choice)
  var_prompt('computer_choice', computer_choice)

  20.times do
    print '.'
    sleep(0.03)
  end
  puts '.'
end

# display board
def display_score_board(score)
  puts "\n"
  puts "   Player: #{score['player']}"
  puts "   Computer: #{score['computer']}"
  puts "   Ties: #{score['tie']}"
  puts "\n"
  puts "   Total Games: #{score['total']}"
  puts '.....................'
end

# displays final winner after all rounds
def display_total_winner(score)
  puts '############################'
  if score['player'] > score['computer']
    puts "=> PLAYER WINS: #{score['player']} to #{score['computer']}!"
  elsif score['player'] < score['computer']
    puts "=> COMPUTER WINS: #{score['computer']} to #{score['player']}!"
  else
    puts '=> It\'s a draw!'
  end
  puts '############################'
end

# countdown printer to start of game
def display_countdown
  [3, 2, 1].each do |element|
    puts element.to_s
    sleep(0.75)
  end
  puts 'GO!!!'
  sleep(0.5)
end

## Scorekeeper Methods
# determine winner
def determine_victor(user_choice, computer_choice)
  victory = { 'rock' => ['scissors', 'lizard'],
              'paper' => ['rock', 'spock'],
              'scissors' => ['paper', 'lizard'],
              'lizard' => ['paper', 'spock'],
              'spock' => ['rock', 'scissors'] }

  if victory[user_choice].include?(computer_choice)
    'player'
  elsif victory[computer_choice].include?(user_choice)
    'computer'
  else
    'tie'
  end
end

# score tracker
def add_score(victor, score)
  score['total'] += 1
  score[victor] += 1
end

# ask player for another match
def play_again?
  prompt('play_again')
  gets.chomp
end

# player hits enter for next round
def next_round
  puts 'Hit [enter] for next round!'
  gets
end

# returns true if player or computer wins 3 rounds
def end_game?(score)
  score['player'] == 3 || score['computer'] == 3
end

## Main Program
system('clear')
score = { 'player' => 0, 'computer' => 0, 'tie' => 0, 'total' => 0 }
prompt('welcome')
display_countdown

loop do
  system('clear')

  user_choice = get_user_choice
  computer_choice = computer_choice_generator

  display_choices(user_choice, computer_choice)

  victor = determine_victor(user_choice, computer_choice)
  add_score(victor, score)

  display_action(user_choice, computer_choice)
  display_victor(victor)
  display_score_board(score)

  next_round unless end_game?(score)

  break display_total_winner(score) if end_game?(score)
end
