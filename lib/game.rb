class Game

  class IllegalMoveError < StandardError; end
  class IllegalStateError < StandardError; end

  # Number of houses.
  NUM_HOUSES = 6
  # Index of players' stores.
  STORE_INDEX_P1 = NUM_HOUSES
  STORE_INDEX_P2 = NUM_HOUSES * 2 + 1

  # Holds the number of seeds in each house.
  @stores
  @history
  @current_player
  @num_seeds

  attr_reader :stores, :history, :current_player, :num_seeds

  # Initializes a new engine, optionally with the default number of seeds in each house.
  def initialize(num_seeds = 6)
    @stores = Array.new(NUM_HOUSES * 2 + 2, num_seeds)
    @stores[STORE_INDEX_P1] = 0
    @stores[STORE_INDEX_P2] = 0
    @history = Array.new
    @current_player = :P1
    @num_seeds = num_seeds
  end

  # Sows the seeds from the given index.
  def sow(index)
    if index < 0 or index > @stores.length
      raise IllegalMoveError, "Index #{i} does not exist (Number of houses is #{@stores.length})"
    elsif index == STORE_INDEX_P1 or index == STORE_INDEX_P2
      raise IllegalMoveError, "Player must not sow seeds from the store"
    elsif has_current_player_won
      raise IllegalMoveError, "Game is over"
    elsif (current_player == :P1 and index > STORE_INDEX_P1) or
        (current_player == :P2 and index < STORE_INDEX_P1)
      raise IllegalMoveError, "Current player must not sow from the opponent's houses"
    elsif @stores[index] == 0
      raise IllegalMoveError, "House is empty."
    end

    # Copy to history.
    @history.push({ player: current_player, stores: Array.new(@stores) })

    # Perform sow
    num_seeds = @stores[index]
    # Empty house.
    @stores[index] = 0
    # Sow in other houses.
    i = 1
    while num_seeds > 0 do
      house = (index + i) % @stores.length
      if (@current_player == :P1 and house == STORE_INDEX_P2) or
          (@current_player == :P2 and house == STORE_INDEX_P1)
        # Skip opponent's store.
        i += 1
        next
      end

      @stores[house] += 1
      num_seeds -= 1
      i += 1
    end

    # If last seed lands in empty house (size now 1), take opposite store.
    if current_players_houses.cover?((index + i - 1) % @stores.length) and
        #i > NUM_HOUSES and
        @stores[(index + i - 1) % @stores.length] == 1
      opposite = NUM_HOUSES * 2 - ((index + i - 1) % @stores.length)
      # Put to store.
      @stores[current_players_store] += @stores[opposite]
      @stores[current_players_store] += 1
      # Empty houses.
      @stores[opposite] = 0
      @stores[(index + i - 1) % @stores.length] = 0
    end

    # Check if game has ended.
    if has_current_player_won
      # Move opponent's seeds to current player's store.
      range, store = 0
      if @current_player == :P1
        range = player_2_houses
        store = STORE_INDEX_P1
      else
        range = player_1_houses
        store = STORE_INDEX_P2
      end

      range.each do |i|
        @stores[store] += @stores[i]
        @stores[i] = 0
      end
    end

    # Change turn if last seed did not land in own store.
    if !has_current_player_won and (index + i - 1) % @stores.length != current_players_store
      @current_player = @current_player == :P1 ? :P2 : :P1
    end
  end

  # Undoes a number of moves.
  def undo(moves = 1)
    raise IllegalStateError, "Cannot undo #{moves} moves. "\
                             "Only #{@history.length} moves performed."\
                             if history.length < moves

    state = @history.pop
    @current_player = state[:player]
    @stores = state[:stores]

  end


  # Returns the index of the current player's store.
  def current_players_store
    return @current_player == :P1 ? STORE_INDEX_P1 : STORE_INDEX_P2
  end

  # Checks whether current player's houses are empty.
  def has_current_player_won
    current_players_houses.each do |i|
      if @stores[i] != 0
        return false
      end
    end

    true
  end

  # Returns the index-range of the current player's houses.
  def current_players_houses
    if @current_player == :P1
      player_1_houses
    else
      player_2_houses
    end
  end

  # The range of player 1's houses
  def player_1_houses
    0..(STORE_INDEX_P1 - 1)
  end

  # The range of player 2's houses
  def player_2_houses
    (STORE_INDEX_P1 + 1)..(STORE_INDEX_P2 - 1)
  end

  # Prints the board
  # for console testing
  # def to_s
  #   # Combine p2 (top) and p1 (bot) houses, and stores (mid)
  #   top = "   "
  #   mid = ""
  #   bot = "   "
  #   @stores.each_with_index do |v, i|
  #     if i == STORE_INDEX_P1
  #       mid << "%02d\n" % v
  #     elsif i == STORE_INDEX_P2
  #       mid.insert(0, "\n%02d " % v)
  #     elsif i > STORE_INDEX_P1
  #       top.insert(3, "%02d " % v)
  #     else
  #       bot << "%02d " % v
  #       mid << "   "
  #     end
  #   end

  #   top << mid << bot

  # end

end
