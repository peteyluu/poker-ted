class Card
  SUITS = {
    :diamonds => "♦",
    :clubs    => "♣",
    :hearts   => "♥",
    :spades   => "♠"
  }

  VALUES = {
    :two   => "2",
    :three => "3",
    :four  => "4",
    :five  => "5",
    :six   => "6",
    :seven => "7",
    :eight => "8",
    :nine  => "9",
    :ten   => "10",
    :jack  => "J",
    :queen => "Q",
    :king  => "K",
    :ace   => "A"
  }

  def self.suits
    SUITS.keys
  end

  def self.values
    VALUES.keys
  end

  attr_reader :suit, :value

  def initialize(suit, value)
    raise 'bad suit or value' unless Card.suits.include?(suit) && Card.values.include?(value)
    @suit, @value = suit, value
  end

  def to_s
    SUITS[suit] + VALUES[value]
  end

  def <=>(other_card)
    if self == other_card
      0
    elsif self.value != other_card.value
      Card.values.index(self.value) <=> Card.values.index(other_card.value)
    elsif self.suit != other_card.suit
      Card.suits.index(self.suit) <=> Card.suits.index(other_card.suit)
    end
  end
end
