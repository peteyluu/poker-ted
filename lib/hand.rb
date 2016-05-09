require_relative 'card'

class Hand

  RANKS = [
    :royal_flush,
    :straight_flush,
    :low_straight_flush,
    :four_of_a_kind,
    :full_house,
    :flush,
    :straight,
    :low_straight,
    :three_of_a_kind,
    :two_pair,
    :one_pair,
    :high_card,
  ]
  attr_reader :cards

  def initialize(cards)
    raise 'must be five cards' unless cards.length == 5
    @cards = cards.sort
  end

  def inspect_hand
    RANKS.each do |rank|
      return rank if self.send("#{rank}?")
    end
  end

  def [](idx)
    @cards[idx]
  end

  def render
    p @cards.map { |card| card.to_s }
  end

  def beats?(other_hand)
    curr_hand_rank = RANKS.reverse.index(self.inspect_hand)
    other_hand_rank = RANKS.reverse.index(other_hand.inspect_hand)
    identifier_rank = curr_hand_rank <=> other_hand_rank
    case identifier_rank
    when 0
      if curr_hand_rank == 2 && other_hand_rank == 2
        two_pair_tie_breaker(other_hand)
      elsif curr_hand_rank == 1 && other_hand_rank == 1
        one_pair_tie_breaker(other_hand)
      else
        self.find_high_card_idx <=> other_hand.find_high_card_idx
      end
    when 1
      identifier_rank
    when -1
      identifier_rank
    end
  end

  def trade_cards(old_cards, new_cards)
    raise 'bad arguments' unless old_cards.length == new_cards.length
    delete_cards(old_cards) && add_cards(new_cards)
    sort!
    old_cards
  end

  protected

  def retrieve_cards
    h = Hash.new { |h, k| h[k] = 0 }
    @cards.map(&:value).each { |value| h[value] += 1 }
    h
  end

  def find_high_card_idx
    Card.values.index(@cards.map(&:value).last)
  end

  def find_second_high_card
    Card.values.index(@cards.map(&:value).slice(0, 2).last)
  end

  def find_kicker
    Card.values.index(@cards.map(&:value).first)
  end

  private

  def one_pair_tie_breaker(other_hand)
    curr_hand_vals = self.retrieve_cards
    other_hand_vals = other_hand.retrieve_cards

    curr_hand_pair_val = curr_hand_vals.key(2)
    curr_hand_vals.delete(curr_hand_pair_val)
    other_hand_pair_val = other_hand_vals.key(2)
    other_hand_vals.delete(other_hand_pair_val)
    curr_pair_rank = Card.values.index(curr_hand_pair_val)
    other_pair_rank = Card.values.index(other_hand_pair_val)
    ident_one_pair= curr_pair_rank <=> other_pair_rank
    return ident_one_pair unless ident_one_pair.zero?

    curr_hand_vals = curr_hand_vals.keys.map {|val| Card.values.index(val)}
    other_hand_vals = other_hand_vals.keys.map {|val| Card.values.index(val)}

    curr_hand_vals.reverse.each_with_index do |val, idx|
      ident_temp = val <=> other_hand_vals.reverse[idx]
      return ident_temp unless ident_temp.zero?
    end
    0
  end

  def two_pair_tie_breaker(other_hand)
    ident_a = self.find_high_card_idx <=> other_hand.find_high_card_idx
    return ident_a unless ident_a.zero?
    ident_b = self.find_second_high_card <=> other_hand.find_second_high_card
    return ident_b unless ident_b.zero?
    ident_c = self.find_kicker <=> other_hand.find_kicker
    return ident_c unless ident_c.zero?
    0
  end

  def royal_flush?
    royal? && flush?
  end

  def straight_flush?
    straight? && flush?
  end

  def low_straight_flush?
    low_straight? && flush?
  end

  def four_of_a_kind?
    find_set(4)
  end

  def full_house?
    find_set(3) && find_set(2)
  end

  def three_of_a_kind?
    find_set(3)
  end

  def flush?
    @cards.map(&:suit).uniq.count == 1
  end

  def straight?
    if has_card?(:ace) && has_card?(:two)
      false
    else
      high_card_idx = find_high_card_idx
      straight = Card.values[(high_card_idx - 4)..high_card_idx]
      @cards.map(&:value) == straight
    end
  end

  def low_straight?
    straight = Card.values[0..3] << :ace
    @cards.map(&:value) == straight
  end

  def has_card?(value)
    @cards.map(&:value).include?(value)
  end

  def two_pair?
    find_pairs(2)
  end

  def one_pair?
    find_pairs(1)
  end

  def high_card?
    true
  end

  def find_pairs(n)
    h = Hash.new { |h, k| h[k] = 0 }
    @cards.map(&:value).each { |val| h[val] += 1 }
    h.select { |k, v| v == 2 }.length == n
  end

  def royal?
    Card.values[-5..-1].all? { |value| @cards.map(&:value).include?(value) }
  end

  def find_set(n)
    h = Hash.new { |h, k| h[k] = 0 }
    @cards.map(&:value).each { |val| h[val] += 1 }
    !h.select { |k, v| v == n }.empty?
  end

  def add_cards(new_cards)
    @cards.concat(new_cards)
  end

  def delete_cards(old_cards)
    old_cards.each { |card| cards.delete(card) }
  end

  def has_cards?(old_cards)
    old_cards.all? { |card| cards.include?(card) }
  end

  def sort!
    @cards.sort!
  end
end
