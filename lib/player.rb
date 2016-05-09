require_relative 'hand'

class Player
  attr_reader :hand, :bankroll, :folded

  def initialize(bankroll)
    @bankroll = bankroll
  end

  def get_response(prev_bet = nil)
    begin
      print '(c)all or (r)aise or (ck)heck or (f)old > '
      input = gets.chomp
      raise 'must be (c)all or (r)aise or (ck)heck or (f)old' unless ['c','r','ck','f'].include?(input)
      case input
      when 'c'
        if prev_bet.nil?
          send(:make_bet, get_bet)
        else
          send(:make_bet, prev_bet)
        end
      when 'r'
        send(:make_bet, get_bet)
      when 'ck'
        return nil
      when 'f'
        send(:folded)
        return nil
      end
    rescue
      retry
    end
  end

  def unfold
    @folded = false
  end

  def folded
    @folded = true
  end

  def get_bet
    begin
      print "Current bankroll is: #{@bankroll} > "
      bet = gets.chomp.to_i
      raise 'insufficient funds' if bet > @bankroll
    rescue
      retry
    end
    bet
  end

  def make_bet(amt)
    raise 'you folded son' if @folded
    raise 'insufficient funds' if @bankroll.zero?
    raise 'bet exceeds bankroll' if amt > @bankroll
    @bankroll -= amt
    amt
  end

  def collect_winnings(amt)
    @bankroll += amt
  end

  def discard_cards
    print 'Which cards to discard? (up to 3 cards!) (i.e. 0,1,2) > '
    card_indices = gets.chomp.split(',').map(&:to_i)
    old_cards = card_indices.map { |idx| @hand[idx] }
  end

  def deal_in(hand)
    raise 'insufficient funds' if @bankroll.zero?
    @hand = Hand.new(hand)
    @folded = false
  end

  def return_cards
    old_hand = @hand.cards
    @hand = nil
    old_hand
  end
end
