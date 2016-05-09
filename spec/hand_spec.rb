require 'rspec'
require 'spec_helper'
require 'hand'
require 'card'

describe Hand do
  describe '#initialize' do
    let(:cards) {[
      Card.new(:spades, :ace),
      Card.new(:hearts, :ace),
      Card.new(:clubs, :ace),
      Card.new(:diamonds, :ace),
      Card.new(:spades, :ten)
    ]}
    let(:hand) { Hand.new(cards) }

    it 'should have five cards' do
      expect(hand.cards).to match_array(cards)
    end

    let(:cards_a) {[
      Card.new(:spades, :ace),
      Card.new(:hearts, :ace),
      Card.new(:clubs, :ace),
      Card.new(:diamonds, :ace),
    ]}

    it 'should raise error if hand is less than five cards' do
      expect { Hand.new(cards_a) }.to raise_error 'must be five cards'
    end
  end

  describe '#sort' do
    let(:cards_b) {[
      Card.new(:spades, :ace),
      Card.new(:hearts, :king),
      Card.new(:clubs, :queen),
      Card.new(:diamonds, :jack),
      Card.new(:spades, :ten)
    ]}
    let(:hand_b) { Hand.new(cards_b) }

    it 'should sort the hand from low to high card' do
      expect(hand_b.cards).to_not eq(hand_b)
    end
  end

  describe '#trade_cards' do
    let(:cards_c) {[
      Card.new(:spades, :ace),
      Card.new(:spades, :king),
      Card.new(:spades, :two),
      Card.new(:hearts, :ten),
      Card.new(:clubs, :six)
    ]}

    let(:old_cards_c) {[
      Card.new(:spades, :two),
      Card.new(:clubs, :six)
    ]}

    let(:new_cards_c) {[
      Card.new(:hearts, :queen),
      Card.new(:diamonds, :jack)
    ]}

    let(:hand_c) { Hand.new(cards_c) }

    it 'should trade old cards with new cards' do
      hand_c.trade_cards(old_cards_c, new_cards_c)
      expect(hand_c.cards).to_not include(old_cards_c)
    end

    it 'should return old cards' do
      expect(hand_c.trade_cards(old_cards_c, new_cards_c)).to match_array(old_cards_c)
    end

    let(:new_cards_d) {[
      Card.new(:spades, :three),
      Card.new(:hearts, :five),
      Card.new(:diamonds, :nine)
    ]}

    it 'should raise error if old cards does not equal to new_cards' do
      expect do
        hand_c.trade_cards(old_cards_c, new_cards_d)
      end.to raise_error 'bad arguments'
    end
  end

  describe '#inspect_hand' do
    let(:cards_royal) {[
      Card.new(:spades, :ace),
      Card.new(:spades, :king),
      Card.new(:spades, :queen),
      Card.new(:spades, :jack),
      Card.new(:spades, :ten)
    ]}

    let(:cards_strflush) {[
      Card.new(:spades, :nine),
      Card.new(:spades, :eight),
      Card.new(:spades, :seven),
      Card.new(:spades, :six),
      Card.new(:spades, :five)
    ]}

    let(:cards_strflush_low) {[
      Card.new(:diamonds, :ace),
      Card.new(:diamonds, :two),
      Card.new(:diamonds, :three),
      Card.new(:diamonds, :four),
      Card.new(:diamonds, :five)
    ]}

    let(:royal_flush) { Hand.new(cards_royal) }
    let(:straight_flush) { Hand.new(cards_strflush) }
    let(:straight_flush_low) { Hand.new(cards_strflush_low) }

    it 'should return royal flush' do
      expect(royal_flush.inspect_hand).to eq(:royal_flush)
    end

    it 'should return straight flush' do
      expect(straight_flush.inspect_hand).to eq(:straight_flush)
    end

    it 'should return low straight flush' do
      expect(straight_flush_low.inspect_hand).to eq(:low_straight_flush)
    end

    let(:cards_four) {[
      Card.new(:spades, :ace),
      Card.new(:hearts, :ace),
      Card.new(:clubs, :ace),
      Card.new(:diamonds, :ace),
      Card.new(:spades, :ten)
    ]}

    let(:four_of_a_kind) { Hand.new(cards_four) }

    it 'should return four of a kind' do
      expect(four_of_a_kind.inspect_hand).to eq(:four_of_a_kind)
    end

    let(:cards_full) {[
      Card.new(:spades, :king),
      Card.new(:hearts, :king),
      Card.new(:clubs, :king),
      Card.new(:spades, :two),
      Card.new(:hearts, :two)
    ]}

    let(:full_house) { Hand.new(cards_full) }

    it 'should return full house' do
      expect(full_house.inspect_hand).to eq(:full_house)
    end

    let(:cards_flush) {[
      Card.new(:spades, :ace),
      Card.new(:spades, :nine),
      Card.new(:spades, :eight),
      Card.new(:spades, :five),
      Card.new(:spades, :three)
    ]}

    let(:flush) { Hand.new(cards_flush) }

    it 'should return flush' do
      expect(flush.inspect_hand).to eq(:flush)
    end

    let(:cards_low_straight) {[
      Card.new(:spades, :ace),
      Card.new(:spades, :two),
      Card.new(:hearts, :three),
      Card.new(:diamonds, :four),
      Card.new(:clubs, :five)
    ]}

    let(:low_straight) { Hand.new(cards_low_straight) }

    it 'should return straight' do
      expect(low_straight.inspect_hand).to eq(:low_straight)
    end

    let(:cards_three) {[
      Card.new(:spades, :queen),
      Card.new(:hearts, :queen),
      Card.new(:clubs, :queen),
      Card.new(:diamonds, :two),
      Card.new(:diamonds, :ten)
    ]}

    let(:three_of_a_kind) { Hand.new(cards_three) }

    it 'should return three of a kind' do
      expect(three_of_a_kind.inspect_hand).to eq(:three_of_a_kind)
    end

    let(:cards_two_pair) {[
      Card.new(:spades, :jack),
      Card.new(:hearts, :jack),
      Card.new(:clubs, :ten),
      Card.new(:diamonds, :ten),
      Card.new(:spades, :two)
    ]}

    let(:two_pair) { Hand.new(cards_two_pair) }

    it 'should return two pair' do
      expect(two_pair.inspect_hand).to eq(:two_pair)
    end

    let(:cards_one_pair) {[
      Card.new(:spades, :nine),
      Card.new(:hearts, :nine),
      Card.new(:spades, :two),
      Card.new(:spades, :three),
      Card.new(:spades, :four)
    ]}

    let(:one_pair) { Hand.new(cards_one_pair) }

    it 'should return one pair' do
      expect(one_pair.inspect_hand).to eq(:one_pair)
    end

    let(:cards_high) {[
      Card.new(:spades, :ace),
      Card.new(:spades, :jack),
      Card.new(:hearts, :nine),
      Card.new(:hearts, :five),
      Card.new(:clubs, :two)
    ]}

    let(:high_card) { Hand.new(cards_high) }

    it 'should return high card' do
      expect(high_card.inspect_hand).to eq(:high_card)
    end
  end

  describe '#beats?' do
    let(:cards_royal) {[
      Card.new(:spades, :ace),
      Card.new(:spades, :king),
      Card.new(:spades, :queen),
      Card.new(:spades, :jack),
      Card.new(:spades, :ten)
    ]}

    let(:cards_royal_h) {[
      Card.new(:hearts, :ace),
      Card.new(:hearts, :king),
      Card.new(:hearts, :queen),
      Card.new(:hearts, :jack),
      Card.new(:hearts, :ten)
    ]}

    let(:cards_strflush) {[
      Card.new(:spades, :nine),
      Card.new(:spades, :eight),
      Card.new(:spades, :seven),
      Card.new(:spades, :six),
      Card.new(:spades, :five)
    ]}

    let(:royal_flush) { Hand.new(cards_royal) }
    let(:straight_flush) { Hand.new(cards_strflush) }
    let(:royal_hearts) { Hand.new(cards_royal_h) }

    it 'should royal flush beats straight flush' do
      expect(royal_flush.beats?(straight_flush)).to eq(1)
      expect(straight_flush.beats?(royal_flush)).to eq(-1)
    end

    it 'should tie when both hand is royal flush' do
      expect(royal_flush.beats?(royal_hearts)).to eq(0)
    end

    let(:cards_str_flush_high) {[
      Card.new(:spades, :king),
      Card.new(:spades, :queen),
      Card.new(:spades, :jack),
      Card.new(:spades, :ten),
      Card.new(:spades, :nine)
    ]}

    let(:cards_str_flush_high_hearts) {[
      Card.new(:hearts, :king),
      Card.new(:hearts, :queen),
      Card.new(:hearts, :jack),
      Card.new(:hearts, :ten),
      Card.new(:hearts, :nine)
    ]}

    let(:cards_str_flush_low) {[
      Card.new(:spades, :eight),
      Card.new(:spades, :seven),
      Card.new(:spades, :six),
      Card.new(:spades, :five),
      Card.new(:spades, :four)
    ]}

    let(:cards_str_flush_lowest) {[
      Card.new(:clubs, :ace),
      Card.new(:clubs, :two),
      Card.new(:clubs, :three),
      Card.new(:clubs, :four),
      Card.new(:clubs, :five)
    ]}

    let(:str_flush_high) { Hand.new(cards_str_flush_high) }
    let(:str_flush_low) { Hand.new(cards_str_flush_low) }
    let(:str_flush_high_hearts) { Hand.new(cards_str_flush_high_hearts) }
    let(:str_flush_lowest) { Hand.new(cards_str_flush_lowest) }

    it 'should high flush beats low flush' do
      expect(str_flush_high.beats?(str_flush_low)).to eq(1)
    end

    it 'should high flush beats lowest flush' do
      expect(str_flush_high.beats?(str_flush_lowest)).to eq(1)
    end

    it 'should return 0 if tie' do
      expect(str_flush_high.beats?(str_flush_high_hearts)).to eq(0)
    end

    let(:cards_four_queen) {[
      Card.new(:spades, :queen),
      Card.new(:hearts, :queen),
      Card.new(:clubs, :queen),
      Card.new(:diamonds, :queen),
      Card.new(:spades, :ten)
    ]}

    let(:cards_full) {[
      Card.new(:spades, :jack),
      Card.new(:hearts, :jack),
      Card.new(:clubs, :jack),
      Card.new(:hearts, :ten),
      Card.new(:clubs, :ten)
    ]}

    let(:four_of_a_kind_queen) { Hand.new(cards_four_queen) }
    let(:full_house) { Hand.new(cards_full) }

    it 'should four of a kind beats full house' do
      expect(four_of_a_kind_queen.beats?(full_house)).to eq(1)
      expect(full_house.beats?(four_of_a_kind_queen)).to eq(-1)
    end

    let(:cards_flush) {[
      Card.new(:spades, :ace),
      Card.new(:spades, :queen),
      Card.new(:spades, :ten),
      Card.new(:spades, :eight),
      Card.new(:spades, :six)
    ]}

    let(:flush) { Hand.new(cards_flush) }

    it 'should full house beats flush' do
      expect(full_house.beats?(flush)).to eq(1)
      expect(flush.beats?(full_house)).to eq(-1)
    end

    let(:cards_low_straight) {[
      Card.new(:hearts, :ace),
      Card.new(:hearts, :two),
      Card.new(:hearts, :three),
      Card.new(:hearts, :four),
      Card.new(:spades, :five)
    ]}

    let(:low_str) { Hand.new(cards_low_straight) }

    it 'should flush beats straight' do
      expect(flush.beats?(low_str)).to eq(1)
    end

    let(:cards_high_straight) {[
      Card.new(:clubs, :two),
      Card.new(:clubs, :three),
      Card.new(:clubs, :four),
      Card.new(:clubs, :five),
      Card.new(:diamonds, :six)
    ]}

    let(:high_str) { Hand.new(cards_high_straight) }

    it 'should high straight beats low straight' do
      expect(high_str.beats?(low_str)).to eq(1)
      expect(low_str.beats?(high_str)).to eq(-1)
    end

    let(:cards_three) {[
      Card.new(:spades, :ten),
      Card.new(:hearts, :ten),
      Card.new(:clubs, :ten),
      Card.new(:spades, :two),
      Card.new(:diamonds, :three)
    ]}

    let(:three_of_a_kind) { Hand.new(cards_three) }

    it 'should low straight beats three of a kind' do
      expect(low_str.beats?(three_of_a_kind)).to eq(1)
    end

    let(:cards_two_pair_ace_king) {[
      Card.new(:spades, :ace),
      Card.new(:hearts, :ace),
      Card.new(:spades, :king),
      Card.new(:hearts, :king),
      Card.new(:clubs, :ten)
    ]}

    let(:cards_two_pair_ace_queen) {[
      Card.new(:clubs, :ace),
      Card.new(:diamonds, :ace),
      Card.new(:spades, :queen),
      Card.new(:hearts, :queen),
      Card.new(:clubs, :ten)
    ]}

    let(:cards_two_pair_king_ten) {[
      Card.new(:spades, :king),
      Card.new(:hearts, :king),
      Card.new(:spades, :ten),
      Card.new(:hearts, :ten),
      Card.new(:clubs, :two)
    ]}

    let(:cards_two_pair_ace_king_low) {[
      Card.new(:clubs, :ace),
      Card.new(:diamonds, :ace),
      Card.new(:clubs, :king),
      Card.new(:diamonds, :king),
      Card.new(:clubs, :two)
    ]}

    let(:cards_two_pair_ace_king_tie) {[
        Card.new(:clubs, :ace),
        Card.new(:diamonds, :ace),
        Card.new(:clubs, :king),
        Card.new(:diamonds, :king),
        Card.new(:diamonds, :ten)
      ]}

    let(:two_pair_ace_king) { Hand.new(cards_two_pair_ace_king) }
    let(:two_pair_ace_queen) { Hand.new(cards_two_pair_ace_queen) }
    let(:two_pair_king_ten) { Hand.new(cards_two_pair_king_ten) }
    let(:two_pair_ace_king_low_kick) { Hand.new(cards_two_pair_ace_king_low) }
    let(:two_pair_ace_king_tie) { Hand.new(cards_two_pair_ace_king_tie) }

    it 'should three of a kind beats two pair' do
      expect(three_of_a_kind.beats?(two_pair_ace_king)).to eq(1)
    end

    it 'should high two pair beats low two pair' do
      expect(two_pair_ace_king.beats?(two_pair_king_ten)).to eq(1)
    end

    it 'should two pair ace king beats two pair ace queen' do
      expect(two_pair_ace_king.beats?(two_pair_ace_queen)).to eq(1)
    end

    it 'should two pair ace king beats two pair ace king on kicker' do
      expect(two_pair_ace_king.beats?(two_pair_ace_king_low_kick)).to eq(1)
    end

    it 'should two pair ace king ties two pair ace king on kicker' do
      expect(two_pair_ace_king.beats?(two_pair_ace_king_tie)).to eq(0)
    end

    let(:cards_one_pair_ace) {[
      Card.new(:spades, :ace),
      Card.new(:hearts, :ace),
      Card.new(:spades, :king),
      Card.new(:clubs, :ten),
      Card.new(:diamonds, :two)
    ]}

    let(:cards_one_pair_king) {[
      Card.new(:hearts, :king),
      Card.new(:clubs, :king),
      Card.new(:spades, :queen),
      Card.new(:diamonds, :ten),
      Card.new(:spades, :two)
    ]}

    let(:cards_one_pair_ace_q) {[
      Card.new(:clubs, :ace),
      Card.new(:diamonds, :ace),
      Card.new(:clubs, :queen),
      Card.new(:hearts, :ten),
      Card.new(:diamonds, :three)
    ]}

    let(:cards_one_pair_ace_kick2) {[
      Card.new(:clubs, :ace),
      Card.new(:diamonds, :ace),
      Card.new(:clubs, :king),
      Card.new(:clubs, :nine),
      Card.new(:diamonds, :two)
    ]}

    let(:cards_one_pair_ace_kicker) {[
      Card.new(:clubs, :ace),
      Card.new(:diamonds, :ace),
      Card.new(:clubs, :king),
      Card.new(:hearts, :ten),
      Card.new(:diamonds, :three)
    ]}

    let(:cards_one_pair_ace_tie) {[
      Card.new(:clubs, :ace),
      Card.new(:diamonds, :ace),
      Card.new(:clubs, :king),
      Card.new(:hearts, :ten),
      Card.new(:diamonds, :two)
    ]}

    let(:cards_one_pair_jacks) {[
      Card.new(:diamonds, :four),
      Card.new(:diamonds, :five),
      Card.new(:clubs, :seven),
      Card.new(:hearts, :jack),
      Card.new(:spades, :jack)
    ]}

    let(:cards_one_pair_ten) {[
      Card.new(:hearts, :six),
      Card.new(:spades, :eight),
      Card.new(:clubs, :ten),
      Card.new(:hearts, :ten),
      Card.new(:spades, :ace)
    ]}

    let(:cards_one_pair_jacks_eight) {[
      Card.new(:spades, :four),
      Card.new(:spades, :five),
      Card.new(:diamonds, :eight),
      Card.new(:clubs, :jack),
      Card.new(:diamonds, :jack)
    ]}

    let(:one_pair_ace_high) { Hand.new(cards_one_pair_ace) }
    let(:one_pair_king) { Hand.new(cards_one_pair_king) }
    let(:one_pair_ace_q) { Hand.new(cards_one_pair_ace_q) }
    let(:one_pair_ace_kick2) { Hand.new(cards_one_pair_ace_kick2) }
    let(:one_pair_ace_kicker) { Hand.new(cards_one_pair_ace_kicker) }
    let(:one_pair_ace_tie) { Hand.new(cards_one_pair_ace_tie) }

    let(:one_pair_ten) { Hand.new(cards_one_pair_ten) }
    let(:one_pair_jack) { Hand.new(cards_one_pair_jacks) }

    let(:one_pair_jack_eight) { Hand.new(cards_one_pair_jacks_eight) }


    it 'should pair aces beats pair kings' do
      expect(one_pair_ace_high.beats?(one_pair_king)).to eq(1)
    end

    it 'should pair aces high kicker beats pair aces low kicker' do
      expect(one_pair_ace_high.beats?(one_pair_ace_q)).to eq(1)
    end

    it 'should pair aces second high kick beats pair aces low second kick' do
      expect(one_pair_ace_high.beats?(one_pair_ace_kick2)).to eq(1)
    end

    it 'should higher kicker beats low kicker' do
      expect(one_pair_ace_high.beats?(one_pair_ace_kicker)).to eq(-1)
    end

    it 'should tie based on kicker' do
      expect(one_pair_ace_high.beats?(one_pair_ace_tie)).to eq(0)
    end

    it 'should high pair beats low pair' do
      expect(one_pair_jack.beats?(one_pair_ten)).to eq(1)
    end

    it 'should tie and compare next high card' do
      expect(one_pair_jack_eight.beats?(one_pair_jack)).to eq(1)
    end
  end
end
