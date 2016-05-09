require 'rspec'
require 'spec_helper'
require 'deck'
require 'card'

describe Deck do
  subject(:deck) { Deck.new }

  describe '::init_deck' do
    let(:cards) { Deck.init_deck }
    it 'should generate a deck of cards' do
      expect(cards.count).to eq(52)
    end
  end

  describe '#initialize' do
    it 'should create a deck' do
      expect(deck).to be_a(Deck)
    end

    it 'should be a deck of 52 cards' do
      expect(deck.count).to eq(52)
    end
  end

  describe '#shuffle' do
    it 'should shuffle the deck' do
      expect(deck.shuffle).to_not eq(deck)
    end
  end

  describe '#deal' do
    deck = Deck.new
    deck.shuffle
    card = deck.deal(1)
    it 'should deal one card' do
      expect(card.first).to be_a(Card)
    end

    it 'should decrement the deck by one' do
      expect(deck.count).to eq(51)
    end
  end

  describe '#add' do
    deck = Deck.new
    deck.shuffle
    cards = deck.deal(5)

    it 'should decrement the deck by five' do
      expect(deck.count).to eq(47)
    end

    it 'should increment the deck by five' do
      expect(deck.add(cards).count).to eq(52)
    end
  end
end
