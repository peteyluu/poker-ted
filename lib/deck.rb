require_relative 'card'

class Deck
  def self.init_deck
    cards = []
    Card.suits.each do |suit|
      Card.values.each do |value|
        cards << Card.new(suit, value)
      end
    end
    cards
  end

  def initialize(cards = Deck.init_deck)
    @deck = cards
  end

  def deal(n)
    @deck.pop(n)
  end

  def count
    @deck.count
  end

  def shuffle
    @deck.shuffle!
  end

  def add(cards)
    @deck.concat(cards)
  end
end
