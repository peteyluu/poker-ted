require 'rspec'
require 'spec_helper'
require 'player'

describe Player do
  let(:hand) { double("hand") }
  subject(:player) { Player.new(100) }

  describe '#initialize' do
    it 'should create the player object' do
      expect(player).to be_a(Player)
    end

    it 'should create attributes for player' do
      expect(player.bankroll).to eq(100)
    end
  end

  describe '#deal_in' do
    xit 'should give player a hand' do
      expect(player.deal_in(hand)).to_not eq(nil)
    end

    it 'should raise error if player has no money' do
      player.make_bet(100)
      expect do
        player.deal_in(hand)
      end.to raise_error 'insufficient funds'
    end
  end

  describe '#return_cards' do
    xit 'should set the player hand to nil' do
      player.return_cards
      expect(player.hand).to eq(nil)
    end
  end

  describe '#make_bet' do
    it 'should decrement from bankroll' do
      expect do
        player.make_bet(10)
        expect(player.bankroll).to eq(90)
      end
    end

    it 'should return the amount' do
      expect(player.make_bet(10)).to eq(10)
    end

    it 'should raise error if bet exceeds the bankroll' do
      expect do
        player.make_bet(101)
      end.to raise_error 'bet exceeds bankroll'
    end

    it 'should raise error if player has no money' do
      expect do
        player.make_bet(100)
        player.make_bet(10)
      end.to raise_error 'insufficient funds'
    end

    it 'should raise error if player folded' do
      expect do
        player.folded
        player.make_bet(10)
      end.to raise_error 'you folded son'
    end
  end

  describe '#collect_winnings' do
    it 'should increment the bankroll' do
      player.collect_winnings(100)
      expect(player.bankroll).to eq(200)
    end
  end

  describe '#get_response' do
    it 'should send to #make_bet if call' do
      expect(player).to respond_to(:get_response)
    end
  end
end
