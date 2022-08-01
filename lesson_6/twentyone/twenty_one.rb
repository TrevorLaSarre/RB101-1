=begin
1. Initialize deck
        create deck of cards
        sort the deck
2. Deal cards to player and dealer
        deal out cards to player and computer (removing from the deck)
3. Player turn: hit or stay
        player turn (hit, stay)
4. If player bust, dealer wins
5. Dealer turn: hit or stay
  - repeat until total >= 17
        dealer(computer) decides
6. If dealer bust, player wins.
7. Compare cards and Declare Winner


take turns
  dealer(computer) decides
  player turn (hit, stay)
determing winners - 21 or highest without going over 21
  assign values to cards and add up
      all face cards are 10
      all numbered cards are their value
      ace can be 1 or 11 based on the current score
        1 if 11 would cause player or dealer to bust
        this also includes the case for multiple aces in a hand (an ace by ace basis) baduhn


=end
CARDS = [2, 3, 4, 5, 6, 7, 8, 9, 10, :jack, :queen, :king, :ace]

DECK_MAKEUP = {
                hearts:   CARDS.dup,
                clubs:    CARDS.dup,
                diamonds: CARDS.dup,
                spades:   CARDS.dup
}

def create_deck
  deck = []
  DECK_MAKEUP.each do |suit, ranks|
    ranks.each do |rank|
      deck << [suit, rank]
    end
  end
  deck
end


# def display_card(card)
#   puts "+---------+" 
#   puts "|".ljust(8) + "#{card[1]}".ljust(2) + "|"
#   puts "|         |"
#   puts "|".ljust(6)  +  "#{card[0]}" +     "|".rjust(6)
#   puts "|         |"
#   puts "|" + "#{card[1]}".rjust(2)  + "|".rjust(8)
#   puts "+---------+"
# end

def display_card(card)
  cards = []
  cards << "+---------+" 
  cards << "|".ljust(8) + "#{card[1]}".ljust(2) + "|"
  cards << "|         |"
  cards << "|".ljust(6)  +  "#{card[0]}" +     "|".rjust(6)
  cards << "|         |"
  cards << "|" + "#{card[1]}".rjust(2)  + "|".rjust(8)
  cards << "+---------+"
  cards
end


suits = ['♠', '♣', '♥', '♦']


table = []
player_cards = [['♠', '10'], ['♣', '6'] ]

player_cards.map! do |card|
  display_card(card)
end

puts player_cards.transpose.map {|card| card.join('  ') }
# Main Program
# deck = create_deck.shuffle!
# Deal cards to player
# deal to dealer
# loop
#   Player turn
#   check bust
# end
# loop
#   dealer turn
#   check win/bust
# end
# check winner
# play again?


p deck

