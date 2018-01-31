require_relative 'station'
require_relative 'journey'


class Oystercard

  DEFAULT_BALANCE = 0
  MINIMUM_BALANCE = 1
  DEFAULT_LIMIT = 90
  attr_reader :balance, :journey_history, :current_journey

  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
    @journey_history = []
  end

  def top_up(amount)
    raise "Maximum balance of #{DEFAULT_LIMIT} exceeded" if limit_reached?(amount)
    @balance += amount
  end

  def in_journey?
    !!@entry_station
  end

  def touch_in(station)
    raise "Minimum balance not met" if @balance < MINIMUM_BALANCE
    store_incomplete_journey
    # need to charge for the incomplete journey
    @current_journey = Journey.new(station)
  end

  def touch_out(station)
    @current_journey.exit_station = station
    deduct(fare)
    save_journey
  end

  private

  def limit_reached?(amount)
    (@balance + amount) > DEFAULT_LIMIT
  end

  def fare
    if @current_journey.entry_station == nil && @current_journey.exit_station != nil
      6
    else
      MINIMUM_BALANCE
    end
  end

  def deduct(fare)
    @balance -= fare
  end

  def store_incomplete_journey
    if @current_journey != nil
      #if there is an unfinished current_journey in progress, push it into the journey history
      if @current_journey.exit_station == nil && @current_journey.entry_station != nil
        @journey_history << @current_journey
      elsif @current_journey.exit_station != nil && @current_journey.entry_station == nil
        @journey_history << @current_journey
      end

    end
  end

  def save_journey
    @journey_history << @current_journey
  end

end
