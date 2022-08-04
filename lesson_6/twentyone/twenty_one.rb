CARDS = [2, 3, 4, 5, 6, 7, 8, 9, 10, 'J', 'Q', 'K', 'A']
GOAL_VALUE = 21
DEALER_MIN = 17

SUITS = ['♥', '♣', '♦', '♠']

DECK_MAKEUP = { SUITS[0] => CARDS.dup,
                SUITS[1] => CARDS.dup,
                SUITS[2] => CARDS.dup,
                SUITS[3] => CARDS.dup }

def prompt(message)
  puts "=> #{message}"
end

def create_deck
  deck = []
  DECK_MAKEUP.each do |suit, ranks|
    ranks.each do |rank|
      deck << [suit, rank]
    end
  end
  deck
end

# rubocop:disable Metrics/AbcSize
def card_image(card, spacing) # dynamic card spacer
  cards = []
  cards << "+" + ("-" * spacing[1]) + "+"
  cards << "|".ljust(spacing[0]) + card[1].to_s.ljust(2) + "|"
  cards << "|" + (" " * spacing[1]) + "|"
  cards << "|".ljust(spacing[2]) + card[0] + "|".rjust(spacing[2])
  cards << "|" + (" " * spacing[1]) + "|"
  cards << "|" + card[1].to_s.rjust(2) + "|".rjust(spacing[0])
  cards << "+" + ("-" * spacing[1]) + "+"
  cards
end
# rubocop:enable Metrics/AbcSize

def deal_card!(deck)
  deck.pop
end

def player_turn(deck)
  loop do
    prompt "What would you like to do? (hit or stay)"
    move = gets.chomp
    if move.downcase == 'h' || move.downcase == 'hit'
      break deal_card!(deck)
    elsif move.downcase == 's' || move.downcase == 'stay'
      break nil
    end
    prompt "Not a valid move!"
  end
end

def dynamic_spacing(cards, spacing)
  if cards.size > 5
    difference = cards.size - 5
    difference += 1 unless difference.even?
    spacing.map!.with_index do |num, idx|
      if idx != 2
        num - difference
      else
        num - (difference / 2)
      end
    end
  else
    spacing
  end
end

def display_cards(cards)
  default_spacing = [8, 9, 5]
  spacing = dynamic_spacing(cards, default_spacing)

  table = cards.map do |card|
    card_image(card, spacing)
  end
  puts(table.transpose.map { |sections| sections.join(' ') })
end

def display_table(player_hand, dealer_hand)
  clear
  prompt "Dealer Cards: #{count_score(dealer_hand)}"
  display_cards(dealer_hand)
  prompt "Player Cards: #{count_score(player_hand)}"
  display_cards(player_hand)
end

def clear
  system('clear') || system('cls')
end

def count_aces(cards)
  cards.map do |_suit, rank|
    rank
  end.count('A')
end

def count_score(cards)
  score = score_total(cards)
  aces = count_aces(cards)
  loop do
    if score > GOAL_VALUE && aces > 0
      score -= 10
      aces -= 1
    else
      break score
    end
  end
  score
end

def score_total(cards)
  cards.map do |_suit, rank|
    if rank.class == String
      case rank
      when 'A' then 11
      when ' ' then 0
      else
        10
      end
    else
      rank
    end
  end.sum
end

def bust?(cards)
  count_score(cards) > GOAL_VALUE
end

def display_busted(player_hand, dealer_hand)
  if bust?(player_hand)
    prompt "YOU BUST!!!"
  elsif bust?(dealer_hand)
    prompt "DEALER BUSTS!!!"
  end
end

def display_winner(player_hand, dealer_hand)
  player = count_score(player_hand)
  dealer = count_score(dealer_hand)
  if player < dealer && dealer
    prompt "Dealer Wins..."
  elsif player > dealer && player
    prompt "You Winsdeded!!!"
  else
    prompt "No Winner"
  end
end

# rubocop:disable Metrics/AbcSize
# rubocop:disable Metrics/CyclomaticComplexity
# rubocop:disable Metrics/MethodLength
# rubocop:disable Metrics/PerceivedComplexity
def main
  score = { Player: 0, Dealer: 0, Ties: 0}
  loop do
    deck = create_deck.shuffle
    player_hand = []
    dealer_hand = []

    2.times do # deal out cards
      player_hand << deal_card!(deck)
      dealer_hand << deal_card!(deck)
    end

    display_table(player_hand, [dealer_hand[0], ['?', ' ']])

    # player turn
    until player_hand.last.nil?
      player_hand << player_turn(deck)
      unless player_hand.last.nil?
        display_table(player_hand, [dealer_hand[0], ['?', ' ']])
      end
      break if player_hand.last.nil? || bust?(player_hand)
    end
    player_hand.pop if player_hand.last.nil?

    display_table(player_hand, dealer_hand)

    # Dealer turn
    while count_score(dealer_hand) < DEALER_MIN && !bust?(player_hand)
      sleep(1)
      dealer_hand << deal_card!(deck)
      display_table(player_hand, dealer_hand)
    end

    display_table(player_hand, dealer_hand)
    display_busted(player_hand, dealer_hand)

    if bust?(player_hand)
      prompt "Dealer Wins..."
    elsif bust?(dealer_hand)
      prompt "You Win!!!"
    else
      display_winner(player_hand, dealer_hand)
    end
    prompt "Play Again? y/n"
    again = gets.chomp.downcase
    break unless again.start_with?('y')
  end
  prompt "Thanks for playing"
end
# rubocop:enable Metrics/AbcSize
# rubocop:enable Metrics/CyclomaticComplexity
# rubocop:enable Metrics/MethodLength
# rubocop:enable Metrics/PerceivedComplexity

main

# If interested, check out my dynamic card size display for multiple cards (works up to 11)
# deck = create_deck
# display_cards(deck[0...5])
# display_cards(deck[0...11])
