require 'rspec'
require 'spec_helper'
require 'card'

describe Card do

  describe '#initialize' do
    let(:card) { Card.new(:spades, :ace) }

    it 'should accept a card' do
      expect(card).to be_a(Card)
    end

    it 'should equal suit' do
      expect(card.suit).to eq(:spades)
    end

    it 'should equal value' do
      expect(card.value).to eq(:ace)
    end

    it 'should raise an error on suit' do
      expect { Card.new(:dogs, :ace) }.to raise_error 'bad suit or value'
    end

    it 'should raise an error on value' do
      expect { Card.new(:spades, :cat) }.to raise_error 'bad suit or value'
    end
  end

  describe '#to_s' do
    let(:spades_ace) { Card.new(:spades, :ace) }
    it 'should print the card' do
      expect(spades_ace.to_s).to eq('♠A')
    end
  end
end
