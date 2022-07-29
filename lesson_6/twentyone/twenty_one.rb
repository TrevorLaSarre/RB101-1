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

deck_makeup = {
                hearts:   CARDS.dup,
                clubs:    CARDS.dup,
                diamonds: CARDS.dup,
                spades:   CARDS.dup
}

def create_deck(deck_makeup)
  deck = []
  deck_makeup.each do |suit, ranks|
    ranks.each do |rank|
      deck << [suit, rank]
    end
  end
  deck
end

deck = create_deck(deck_makeup)



deck.shuffle!

deck_count = {}
p deck

