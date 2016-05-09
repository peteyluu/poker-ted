require_relative 'deck'
require_relative 'player'

class Game
  attr_reader :players, :deck, :pot

  def initialize(num_of_players)
    @players = []
    num_of_players.times { |player| @players << Player.new(100) }
    @deck = Deck.new
  end

  def play
    until over?
      play_round
    end
    puts "Done son!"
  end

  private

  def over?
    @players.any? { |player| player.bankroll.zero? }
  end

  def play_round
    prep_round
    bet_round
    draw_round
    win_round
  end

  def win_round
    bet_round
    compare_hands
    collect_cards
  end

  def collect_cards
    @players.each { |player| @deck.add(player.return_cards) }
  end

  def compare_hands
    player1_hand = @players.first.hand
    player2_hand = @players.last.hand
    identifier = player1_hand.beats?(player2_hand)
    case identifier
    when 0
      puts "It is a draw!"
      split_pot = @pot / 2
      @players.first.collect_winnings(split_pot)
      @players.last.collect_winnings(split_pot)
    when 1
      puts "Player 0 wins this round!"
      @players.first.collect_winnings(@pot)
    when -1
      puts "Player 1 wins this round!"
      @players.last.collect_winnings(@pot)
    end
  end

  def draw_round
    @players.each do |player|
      old_cards = player.discard_cards
      new_cards = @deck.deal(old_cards.length)
      player.hand.trade_cards(old_cards, new_cards)
      @deck.add(old_cards)
      player.hand.render
    end
  end

  def bet_round
    prev_bet = nil
    raised = true
    while raised
      first_player_checked = false
      raised = false
      @players.each_with_index do |player, idx|
        puts "Current bankroll for Player#{idx} > #{player.bankroll}"
        if prev_bet.nil?
          prev_bet = player.get_response
          first_player_checked = true if prev_bet.nil?
          @pot += prev_bet if prev_bet.is_a?(Integer)
          raised = true if first_player_checked && prev_bet.is_a?(Integer)
        else
          temp_prev_bet = player.get_response(prev_bet)
          if prev_bet == temp_prev_bet || temp_prev_bet.nil?
            raised = false
            break
          end
          if temp_prev_bet > prev_bet
            raised = true
            puts "Previous bet: #{prev_bet}"
            puts "Raised bet: #{temp_prev_bet}"
            prev_bet = temp_prev_bet - prev_bet
            puts "To call: #{prev_bet}"
          end
          @pot += temp_prev_bet
        end
      end
    end
  end

  def prep_round
    @pot = 0
    @deck.shuffle
    @players.each_with_index do |player, idx|
      player.unfold
      puts "Current bankroll for Player#{idx} > #{player.bankroll}"
      @pot += player.make_bet(1)
      player.deal_in(@deck.deal(5))
      player.hand.render
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  Game.new(2).play
end
