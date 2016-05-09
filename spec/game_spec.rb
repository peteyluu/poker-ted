require 'rspec'
require 'spec_helper'
require 'game'

describe Game do
  subject(:game) { Game.new(2) }

  describe '#initialize' do
    it 'should create a deck' do
      expect(game.deck.count).to eq(52)
    end

    it 'should create players' do
      expect(game.players.length).to eq(2)
    end

    xit 'should keep track whose turn it is' do
      expect(game.curr_player).to_not be(nil)
    end

    xit 'should keep track of the amount in the pot' do
      expect(game.pot).to eq(0)
    end
  end
end
