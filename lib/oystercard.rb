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
    @current_journey = nil
  end

  def top_up(amount)
    raise "Maximum balance of #{DEFAULT_LIMIT} exceeded" if limit_reached?(amount)
    @balance += amount
  end

  def in_journey?
    !!@entry_station
  end

  def touch_in(station)
    @current_journey = Journey.new(station)
    # raise "you didn't touch out" if @exit_station == nil
    raise "Minimum balance not met" if @balance < MINIMUM_BALANCE
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
    MINIMUM_BALANCE
  end

  def deduct(fare)
    @balance -= fare
  end

  def save_journey
    @journey_history << current_journey
  end

end
